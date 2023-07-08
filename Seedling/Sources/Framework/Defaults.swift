// Copyright Team Seedling ©

import Foundation

class Defaults
{
    static var hasPopulatedDefaultData: Bool
    {
        get
        {
            NSUbiquitousKeyValueStore.default.bool(forKey: "hasPopulatedDefaultData")
        }
        set
        {
            NSUbiquitousKeyValueStore.default.set(newValue, forKey: "hasPopulatedDefaultData")
        }
    }
}
