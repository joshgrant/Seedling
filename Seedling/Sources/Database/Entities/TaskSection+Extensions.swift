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
}

extension TaskSection: ListEditable
{
    
}
