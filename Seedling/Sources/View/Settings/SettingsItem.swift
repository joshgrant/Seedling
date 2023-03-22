// Copyright Team Seedling ©

import Foundation

protocol SettingsItem:
    Hashable,
    Identifiable,
    Equatable
{
    static var reuseIdentifier: String { get }
    
    var id: UUID { get }
}

extension SettingsItem
{
    static func == (lhs: Self, rhs: Self) -> Bool
    {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(id)
    }
}
