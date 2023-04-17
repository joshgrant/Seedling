// Copyright Team Seedling ©

import UIKit
import SwiftUI

/// Contains the Extras controller so we can do screen-edge swiping on in
class ExtrasContainerController: UIViewController
{
    // MARK: - Variables
    
    var dayProvider: DayProvider
    var database: Database
    
    private var extrasController: ExtrasController
    private var settingsController: UIHostingController<SettingsView>
    
    private var previousX: CGFloat = 0
    
    lazy var screenEdgeSwipeGesture: UIScreenEdgePanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeSwipe))
        gesture.edges = .right
        gesture.delegate = self
        return gesture
    }()
    
    var tabComponent: TabModule?
    
    // MARK: - Initialization
    
    init(dayProvider: DayProvider, database: Database)
    {
        self.dayProvider = dayProvider
        self.database = database
        
        extrasController = Self.makeExtrasController(dayProvider: dayProvider, database: database)
        settingsController = Self.makeSettingsController()
        
        super.init(nibName: nil, bundle: nil)
        
        self.tabComponent = .init(tab: .extras, controller: self)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // TODO: Reduce this duplication
        
        addChild(settingsController)
        settingsController.view.frame = view.frame
        view.addSubview(settingsController.view)
        settingsController.didMove(toParent: self)
        settingsController.view.transform3D = self.transform(with: 0)
        
        addChild(extrasController)
        extrasController.view.frame = view.frame
        view.addSubview(extrasController.view)
        extrasController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        view.addGestureRecognizer(screenEdgeSwipeGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        view.removeGestureRecognizer(screenEdgeSwipeGesture)
    }
    
    // MARK: - Functions
    
    private func transform(with delta: CGFloat) -> CATransform3D
    {
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 2000
        
        let maxDelta: CGFloat = view.window?.screen.bounds.width ?? 0
        let percent = delta / maxDelta
        let interpolatedValue = (maxDelta - delta) * percent
        return CATransform3DTranslate(transform, 0, 0, interpolatedValue * -10)
    }
    
    // MARK: - Factory
    
    private static func makeExtrasController(dayProvider: DayProvider, database: Database) -> ExtrasController
    {
        .init(dayProvider: dayProvider, database: database)!
    }
    
    private static func makeSettingsController() -> UIHostingController<SettingsView>
    {
        let model = SettingsViewModel()
        let rootView = SettingsView(model: model)
        return .init(rootView: rootView)
    }

    // MARK: - Selectors
    
    @objc func handleScreenEdgeSwipe(_ gesture: UIScreenEdgePanGestureRecognizer)
    {
        let x: CGFloat = gesture.location(in: view).x
        let delta = previousX - x
        
        switch gesture.state
        {
        case .began:
            previousX = x
        case .changed:
            settingsController.view.transform3D = transform(with: delta)
            extrasController.view.transform = .init(translationX: -delta, y: 0)
        case .recognized:
            // TODO: Switch tabs after the animation completes
            // and reset the alpha to 1
            UIView.animate(withDuration: 3.0) {
                self.extrasController.view.alpha = 0
            }
            
            NotificationCenter.default.post(name: .requestShowSettings, object: nil)
            
            UIView.animate(withDuration: 0.5) {
                self.extrasController.view.alpha = 0
                self.settingsController.view.transform3D = CATransform3DIdentity
            } completion: { success in
                self.tabBarController?.selectedIndex = 3
                self.extrasController.view.alpha = 1
                self.extrasController.view.transform = .identity
            }

        case .cancelled:
            // Animate this
            extrasController.view.transform = .identity
        default:
            break
        }
    }
}

extension ExtrasContainerController: UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        true
    }
}
