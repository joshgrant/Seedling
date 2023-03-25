// Copyright Team Seedling ©

import Foundation

class SegmentedCellModel<Option: PickerOption>: SettingsCellModel, ObservableObject
{
    // MARK: - Variables
    
    @Published var selection: Int
    
    var id = UUID()
    var title: String
    var options: [Option]
    var selectionDidChange: (Option) -> Void
    
    // MARK: - Initialization
    
    init(
        title: String,
        options: [Option],
        selection: Int,
        selectionDidChange: @escaping (Option) -> Void)
    {
        self.title = title
        self.options = options
        self.selection = selection
        self.selectionDidChange = selectionDidChange
    }
}

protocol PickerOption: Identifiable, CaseIterable
{
    var sortIndex: Int { get }
    var title: String { get }
}

struct DurationPickerOption: PickerOption
{
    // MARK: - Variables
    
    var id = UUID()
    let sortIndex: Int
    let duration: Int
    
    var title: String
    {
        switch duration
        {
        case 30: return Strings.m30
        case 60: return Strings.hr1
        default: return Strings.m15
        }
    }
    
    // MARK: - Initialization
    
    init(sortIndex: Int, duration: Int)
    {
        self.sortIndex = sortIndex
        self.duration = duration
    }
    
    // MARK: - Functions
    
    static func index(from duration: Int) -> Int
    {
        switch duration
        {
        case 30:
            return 1
        case 60:
            return 2
        default:
            return 0
        }
    }
    
    // MARK: - Instances
    
    static let fifteen = DurationPickerOption(sortIndex: 0, duration: 15)
    static let thirty = DurationPickerOption(sortIndex: 1, duration: 30)
    static let hour = DurationPickerOption(sortIndex: 2, duration: 60)
    
    static var allCases: [DurationPickerOption] = [
        .fifteen,
        .thirty,
        .hour
    ]
}

struct WaterPickerOption: PickerOption
{
    // MARK: - Initialization
    
    let id = UUID()
    let sortIndex: Int
    let ouncesOfWater: Int
    
    var title: String { Strings.ouncesAmount(ouncesOfWater) }
    
    // MARK: - Initialization
    
    init(sortIndex: Int, ouncesOfWater: Int)
    {
        self.sortIndex = sortIndex
        self.ouncesOfWater = ouncesOfWater
    }
    
    // MARK: - Functions
    
    static func index(from ouncesOfWater: Int) -> Int
    {
        switch ouncesOfWater
        {
        case 2:
            return 1
        case 4:
            return 2
        case 8:
            return 3
        default:
            return 0
        }
    }
    
    // MARK: - Instances
    
    static let ouncesOne = WaterPickerOption(sortIndex: 0, ouncesOfWater: 1)
    static let ouncesTwo = WaterPickerOption(sortIndex: 1, ouncesOfWater: 2)
    static let ouncesFour = WaterPickerOption(sortIndex: 2, ouncesOfWater: 4)
    static let ouncesEight = WaterPickerOption(sortIndex: 3, ouncesOfWater: 8)
    
    static var allCases: [WaterPickerOption] = [
        .ouncesOne,
        .ouncesTwo,
        .ouncesFour,
        .ouncesEight
    ]
}
