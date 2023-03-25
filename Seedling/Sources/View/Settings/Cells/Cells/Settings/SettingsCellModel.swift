// Copyright Team Seedling ©

import SwiftUI

protocol SettingsCellModel: Identifiable
{
    var id: UUID { get set }
    var title: String { get }
}
