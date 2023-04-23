// Copyright Team Seedling ©

import SwiftUI

class TabBarItemModel: ObservableObject
{
    var id: Int
    var unselectedImage: Image
    var selectedImage: Image
    var title: String
    @Published var selected: Bool
    
    init(
        id: Int,
        unselectedImage: Image,
        selectedImage: Image,
        title: String,
        selected: Bool)
    {
        self.id = id
        self.unselectedImage = unselectedImage
        self.selectedImage = selectedImage
        self.title = title
        self.selected = selected
    }
}

extension TabBarItemModel: Equatable
{
    static func == (lhs: TabBarItemModel, rhs: TabBarItemModel) -> Bool
    {
        lhs.id == rhs.id
    }
}

extension TabBarItemModel
{
    static let toDo = TabBarItemModel(
        id: 0,
        unselectedImage: SeedlingAsset.toDoUnselected.swiftUIImage,
        selectedImage: SeedlingAsset.toDoSelected.swiftUIImage,
        title: SeedlingStrings.toDo.localizedCapitalized,
        selected: true)
    
    static let schedule = TabBarItemModel(
        id: 1,
        unselectedImage: SeedlingAsset.scheduleUnselected.swiftUIImage,
        selectedImage: SeedlingAsset.scheduleSelected.swiftUIImage,
        title: SeedlingStrings.schedule.localizedCapitalized,
        selected: false)
    
    static let extras = TabBarItemModel(
        id: 2,
        unselectedImage: SeedlingAsset.extrasUnselected.swiftUIImage,
        selectedImage: SeedlingAsset.extrasSelected.swiftUIImage,
        title: SeedlingStrings.extras.localizedCapitalized,
        selected: false)
    
    static let settings = TabBarItemModel(
        id: 3,
        unselectedImage: SeedlingAsset.settingsUnselected.swiftUIImage,
        selectedImage: SeedlingAsset.settingsSelected.swiftUIImage,
        title: SeedlingStrings.settings.localizedCapitalized,
        selected: false)
}
