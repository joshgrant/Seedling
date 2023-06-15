// Copyright Team Seedling ©

import CoreData

extension MealType
{
    static func totalCount(in context: Context) throws -> Int
    {
        let request: NSFetchRequest<MealType> = MealType.fetchRequest()
        return try context.fetch(request).count
    }
}
