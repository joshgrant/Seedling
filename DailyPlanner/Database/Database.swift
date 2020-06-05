//
//  Database.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/8/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import CoreData
import Basic

typealias Context = NSManagedObjectContext

class Database {
    
    // MARK: - Variables
    
    var containerName: String
    
    lazy var container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: containerName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    
    var context: Context { container.viewContext }
    
    // MARK: - Initialization
    
    init(containerName: String)
    {
        self.containerName = containerName
        
        Self.testInit()
    }
    
    static func testInit()
    {
        print(self)
    }
    
    // MARK: - Database operations
    
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
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func testSave() -> Bool
    {
        return false
    }
    
    func reset()
    {
        // Can we get the entities more easily?
        let types = [Day.self,
                     Task.self,
                     Meal.self,
                     Note.self,
                     Pomodoro.self,
                     Water.self,
                     Schedule.self]
        
        do {
            for type in types {
                let request = NSBatchDeleteRequest(fetchRequest: type.fetchRequest())
                try context.execute(request)
            }
        } catch {
            print(error)
        }
    }
    
    func testReset() -> Bool
    {
        return false
    }
}

extension Database: Testable
{
    func prepare() {
        
    }
    
    func test() -> Bool {
        return testSave()
            && testReset()
    }
    
    func cleanup() {
        
    }
}
