// Copyright Team Seedling ©

import UIKit

class DayNavigationTitleComponent
{
    weak var navigationItem: UINavigationItem?
    
    init(day: Day, navigationItem: UINavigationItem? = nil)
    {
        self.navigationItem = navigationItem
        update(day: day)
    }
    
    func update(day: Day)
    {
        let todayPredicate = Date().makeDayPredicate()
        let isToday = todayPredicate.evaluate(with: day)
        
        let formatter = DateFormatter()
        let title: String
        
        if isToday
        {
            formatter.setLocalizedDateFormatFromTemplate(SeedlingStrings.formatDayMonth)
            title = SeedlingStrings.today(formatter.string(from: day.date ?? Date())).localizedCapitalized
        }
        else
        {
            formatter.setLocalizedDateFormatFromTemplate(SeedlingStrings.formatWeekdayDayMonth)
            title = formatter.string(from: day.date ?? Date())
        }
        
        navigationItem?.title = title
    }
}
