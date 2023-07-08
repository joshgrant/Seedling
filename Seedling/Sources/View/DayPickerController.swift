// Copyright Team Seedling ©

import Foundation
import SwiftUI
import UIKit

// TODO: Hide the day navigation tools on the settings tab

class DayPickerController: UIViewController
{
    let context: Context
    let dayProvider: DayProvider
    
    lazy var datePicker: UIDatePicker =
    {
        let datePicker = UIDatePicker()
        datePicker.date = dayProvider.day.date ?? Date()
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.tintColor = SeedlingAsset.orange.color
        datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        return datePicker
    }()
    
    lazy var datePickerHeight: CGFloat =
    {
        datePicker.frame.height
    }()
    
    init(context: Context, dayProvider: DayProvider)
    {
        self.context = context
        self.dayProvider = dayProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.embed(view: datePicker)
        view.backgroundColor = .systemBackground
        guard let presentationController = presentationController as? UISheetPresentationController else { return }
        presentationController.detents = [.custom(resolver: { context in
            return self.datePickerHeight
        })]
    }
    
    @objc func handleDateSelection(_ sender: UIDatePicker)
    {
        dayProvider.day = DayProvider.findOrMakeDay(date: sender.date, context: context)
    }
}
