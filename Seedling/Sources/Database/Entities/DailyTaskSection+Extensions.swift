// Copyright Team Seedling ©

import CoreData

extension DailyTaskSection
{
    static func findOrMakePreviousTaskSection(day: Day, context: Context) -> DailyTaskSection
    {
        let fetchRequest: NSFetchRequest<DailyTaskSection> = DailyTaskSection.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "previousTaskSection == %@ AND day.date == %@", NSNumber(value: true), day.date! as NSDate)
        if let results = try? context.fetch(fetchRequest), let section = results.first
        {
            return section
        }
        else
        {
            let section = DailyTaskSection(context: context)
            section.previousTaskSection = true
            section.day = day
            section.title = Strings.previousTasks
            return section
        }
    }
}
