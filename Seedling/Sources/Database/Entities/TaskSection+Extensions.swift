// Copyright Team Seedling ©

import Foundation
import CoreData

extension TaskSection
{
    var identifier: String
    {
        "taskSectionCellIdentifier"
    }
    
    static func allSections(in context: NSManagedObjectContext) -> [TaskSection]
    {
        return (try? context.fetch(fetchRequest())) ?? []
    }
    
    func propagate(to context: Context)
    {
        let days = Day.todayAndFutureDays(context: context)
        for day in days
        {
            let dailyTaskSection = DailyTaskSection(context: context)
            dailyTaskSection.taskSection = self
            dailyTaskSection.sortIndex = self.sortIndex
            day.addToDailyTaskSections(dailyTaskSection)
        }
        try? context.save()
    }
    
    func delete(from context: NSManagedObjectContext)
    {
        let fetchRequest: NSFetchRequest<DailyTaskSection> = DailyTaskSection.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "day.date >= %@ && taskSection == %@", Date().startOfDay as NSDate, self)
        let results = (try? context.fetch(fetchRequest)) ?? []
        for r in results
        {
            context.delete(r)
        }
        context.delete(self)
        try? context.save()
    }
}

extension TaskSection: ListEditable
{
    
}

