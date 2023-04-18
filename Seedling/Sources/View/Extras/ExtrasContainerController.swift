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
        view.addSubview(settingsController.view)
        settingsController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsController.view.topAnchor.constraint(equalTo: view.topAnchor),
            settingsController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        settingsController.didMove(toParent: self)
        settingsController.view.transform3D = self.transform(with: 0)
        
        addChild(extrasController)
        view.addSubview(extrasController.view)
        extrasController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            extrasController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            extrasController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            extrasController.view.topAnchor.constraint(equalTo: view.topAnchor),
            extrasController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
        
        let offset = (view.bounds.width - abs(delta)) / view.bounds.width
        let zTranslate = -100 * offset
        let xTranslate = 100 * offset
        
        return CATransform3DTranslate(transform, xTranslate, 0, 0)
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
        let velocity = gesture.velocity(in: view)
        
        // TODO: Use the velocity
        
        let delta = x - previousX
        
        print(x + velocity.x)
        
        switch gesture.state
        {
        case .began:
            previousX = x
        case .changed:
            settingsController.view.transform3D = transform(with: delta)
            extrasController.view.transform = .init(translationX: delta, y: 0)
        case .cancelled:
            // Animate this
            extrasController.view.transform = .identity
        case .ended:
            
            // Animate to the settings page
            if (x + velocity.x) < 0
            {
                
                let velocity = abs(velocity.x / view.bounds.width)
                let extrasTransform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
                
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    usingSpringWithDamping: 1,
                    initialSpringVelocity: velocity,
                    options: [.beginFromCurrentState, .curveEaseInOut],
                    animations: {
//                        self.extrasController.view.alpha = 0
                        self.extrasController.view.transform = extrasTransform
                        self.settingsController.view.transform3D = CATransform3DIdentity
                    },
                    completion: { _ in
                        self.extrasController.view.alpha = 1
                        self.extrasController.view.transform = .identity
                        NotificationCenter.default.post(name: .requestShowSettings, object: ["switch_to_settings": true])
                    })
            }
            else
            {
                UIView.animate(withDuration: 0.2) {
                    self.extrasController.view.alpha = 1
                    self.extrasController.view.transform = .identity
                } completion: { success in
                }
            }

        @unknown default:
            break
        }
    }
}

extension ExtrasContainerController: UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
//        if Settings.hideSettings { return false }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        true
    }
}
