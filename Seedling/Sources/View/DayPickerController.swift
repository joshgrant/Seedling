// Copyright Team Seedling ©

import Foundation
import SwiftUI
import UIKit

// TODO: Hide the day navigation tools on the settings tab

class DayPickerController<V: View>: UIHostingController<V>
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        guard let presentationController = presentationController as? UISheetPresentationController else { return }
        presentationController.detents = [.custom(resolver: { context in
            return 375 // TODO: Figure out how to calculate this dynamically
        })]
        // TODO: Figure out why swiping up on the sheet causes the view to
        // be incorrectly sized
    }
}
