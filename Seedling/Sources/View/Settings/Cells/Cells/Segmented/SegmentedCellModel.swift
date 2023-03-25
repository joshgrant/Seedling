// Copyright Team Seedling ©

import Foundation

class SegmentedCellModel: SettingsCellModel, ObservableObject
{
    // MARK: - Variables
    
    var id = UUID()
    var title: String
    var options: [PickerOption]
    var selectionDidChange: (PickerOption) -> Void
    
    // MARK: - Initialization
    
    init(
        title: String,
        options: [PickerOption],
        selectionDidChange: @escaping (PickerOption) -> Void)
    {
        self.title = title
        self.options = options
        self.selectionDidChange = selectionDidChange
    }
}

struct PickerOption: Identifiable
{
    // MARK: - Initialization
    
    var id: Int
    var title: String
    
    // MARK: - Instances
    
    // MARK: Durations
    
    static let fifteen = PickerOption(id: 0, title: Strings.m15)
    static let thirty = PickerOption(id: 1, title: Strings.m30)
    static let hour = PickerOption(id: 2, title: Strings.hr1)
    
    static let durations: [PickerOption] = [
        .fifteen,
        .thirty,
        .hour]
    
    // MARK: Water amounts
    
    static let ouncesOne = PickerOption(id: 0, title: Strings.ouncesAmount(1))
    static let ouncesTwo = PickerOption(id: 1, title: Strings.ouncesAmount(2))
    static let ouncesFour = PickerOption(id: 2, title: Strings.ouncesAmount(4))
    static let ouncesEight = PickerOption(id: 3, title: Strings.ouncesAmount(8))
    
    static let waterAmounts: [PickerOption] = [
        .ouncesOne,
        .ouncesTwo,
        .ouncesFour,
        .ouncesEight]
}
