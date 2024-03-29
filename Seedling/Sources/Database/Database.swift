//
//  Database.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import CoreData

typealias Context = NSManagedObjectContext

class Database
{
    // MARK: - Variables
    
    var containerName: String
    
    lazy var container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: containerName)
        container.loadPersistentStores { (description, error) in
            if let error = error
            {
                assertionFailure(error.localizedDescription)
            }
        }
        return container
    }()
    
    var context: Context { container.viewContext }
    
    var entities: [NSEntityDescription]
    {
        container
            .managedObjectModel
            .entities
    }
    
    // MARK: - Initialization
    
    init(containerName: String)
    {
        self.containerName = containerName
        populateWithDefaultData(shouldReset: true)
    }
}

// MARK: - Database operations
    
extension Database
{
    func save()
    {
        if context.hasChanges
        {
            do
            {
                try context.save()
            }
            catch
            {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    func testSave() -> Bool
    {
        return false
    }
    
    func reset()
    {
        do
        {
            try entities
                .compactMap { $0.name }
                .map { NSFetchRequest(entityName: $0) }
                .map { NSBatchDeleteRequest(fetchRequest: $0) }
                .forEach { try context.execute($0) }
        }
        catch
        {
            print(error)
        }
    }
    
    func testReset() -> Bool
    {
        return false
    }
}

// MARK: - Testable

extension Database: Testable
{
    func prepare()
    {
        
    }
    
    func test() -> Bool
    {
        return testSave()
            && testReset()
    }
    
    func cleanup()
    {
        
    }
}

// MARK: - Data population

extension Database
{
    func populateWithDefaultData(shouldReset: Bool = false)
    {
        if shouldReset
        {
            reset()
            Defaults.hasPopulatedDefaultData = false
        }
        
        if Defaults.hasPopulatedDefaultData { return }
        
        let todoSection = TaskSection(context: context)
        todoSection.title = Strings.toDo.localizedCapitalized
        todoSection.sortIndex = 0
        
        let prioritySection = TaskSection(context: context)
        prioritySection.title = Strings.priorities.localizedCapitalized
        prioritySection.sortIndex = 1
        
        let breakfast = MealType(context: context)
        breakfast.title = Strings.breakfast
        breakfast.sortIndex = 0
        
        let lunch = MealType(context: context)
        lunch.title = Strings.lunch
        lunch.sortIndex = 1
        
        let dinner = MealType(context: context)
        dinner.title = Strings.dinner
        dinner.sortIndex = 2
        
        let snack = MealType(context: context)
        snack.title = Strings.snack
        snack.sortIndex = 3
        
        save()
        
        Defaults.hasPopulatedDefaultData = true
    }
    
}
