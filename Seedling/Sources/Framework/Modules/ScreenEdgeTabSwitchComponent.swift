// Copyright Team Seedling ©

import UIKit

/// This is stored as a property on the view that needs to have the screen edge swipe (the extras controller)
class ScreenEdgeTabSwitchComponent: NSObject
{
    // MARK: - Types
    
    struct GestureData
    {
        var x: CGFloat
        var velocityX: CGFloat
        
        // MARK: - Initialization
        
        init(x: CGFloat, velocityX: CGFloat)
        {
            self.x = x
            self.velocityX = velocityX
        }
        
        init(gesture: UIScreenEdgePanGestureRecognizer, view: UIView)
        {
            self.x = gesture.location(in: view).x
            self.velocityX = gesture.velocity(in: view).x
        }
        
        // MARK: - Functions
        
        func delta(data: GestureData) -> GestureData
        {
            .init(
                x: min(0, data.x - x),
                velocityX: data.velocityX - velocityX)
        }
    }
    
    // MARK: - Variables
    
    /// This represents the starting x position when the pan gesture begins tracking touches
    private var initialAnimationData = GestureData(x: 0, velocityX: 0)
    
    private weak var viewController: UIViewController?
    private weak var secondaryController: UIViewController?
    
    private var primarySnapshot: UIView?
    private var secondarySnapshot: UIView?
    
    private var animationDuration: TimeInterval
    
    private var view: UIView? { viewController?.view }
    
    private lazy var screenEdgeGesture: UIScreenEdgePanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeSwipe))
        gesture.edges = .right
        gesture.delegate = self
        return gesture
    }()
    
    // MARK: - Initialization
    
    init(viewController: UIViewController, secondaryController: UIViewController, animationDuration: TimeInterval = 0.5)
    {
        self.viewController = viewController
        self.secondaryController = secondaryController
        self.animationDuration = animationDuration
        super.init()
        viewController.view.addGestureRecognizer(screenEdgeGesture)
    }
    
    deinit
    {
        viewController?.view.removeGestureRecognizer(screenEdgeGesture)
        primarySnapshot?.removeFromSuperview()
        primarySnapshot = nil
        secondarySnapshot?.removeFromSuperview()
        secondarySnapshot = nil
    }
    
    // MARK: - Selectors
    
    @objc private func handleScreenEdgeSwipe(_ gesture: UIScreenEdgePanGestureRecognizer)
    {
        guard
            let viewController = viewController,
            let view = viewController.view,
            let secondaryController = secondaryController
        else { return }
        let animationData = GestureData(gesture: gesture, view: view)
        
        switch gesture.state
        {
        case .began:
            initialAnimationData = animationData
            
            let secondarySnapshot = Self.makeSnapshotImageView(with: secondaryController)
            secondarySnapshot.transform = secondaryUpdateTransform(delta: initialAnimationData, view: view)
            view.embed(view: secondarySnapshot)
            self.secondarySnapshot = secondarySnapshot
            
            let primarySnapshot = Self.makeSnapshotImageView(with: viewController, shadow: true)
            view.embed(view: primarySnapshot)
            self.primarySnapshot = primarySnapshot
        case .changed:
            let delta = initialAnimationData.delta(data: animationData)
            updateSnapshots(with: delta, view: view)
        case .cancelled:
            animateFailedTransition()
        case .ended:
            if shouldAnimateToSuccessfulTransition(data: animationData)
            {
                animateSuccessfulTransition(
                    initialVelocity: relativeVelocity(gestureVelocityX: animationData.velocityX, view: view),
                    primaryFinalTransform: primaryFinalTransform(with: view))
            }
            else
            {
                animateFailedTransition()
            }
        default:
            break
        }
    }
    
    private func updateSnapshots(with delta: GestureData, view: UIView)
    {
        primarySnapshot?.transform = .init(translationX: delta.x, y: 0)
        secondarySnapshot?.transform = secondaryUpdateTransform(delta: delta, view: view)
    }
}

// MARK: - Animations

extension ScreenEdgeTabSwitchComponent
{
    private func animateSuccessfulTransition(initialVelocity: CGFloat, primaryFinalTransform: CGAffineTransform)
    {
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: initialVelocity,
            options: [.beginFromCurrentState, .curveEaseOut],
            animations: {
                self.animationValuesToHidePrimaryController(primaryTransform: primaryFinalTransform)
            },
            completion: { _ in
                self.animationValuesToResetPrimaryControllerAfterSwitch()
                
                // TODO: Should not be hard-coding the key name
                NotificationCenter.default.post(name: .requestShowSettings, object: ["switch_to_settings": true])
            })
    }
    
    private func animateFailedTransition()
    {
        UIView.animate(
            withDuration: animationDuration * 0.5,
            animations: {
                self.animationValuesToResetPrimaryControllerBeforeSwitch()
            },
            completion: { _ in
                self.animationValuesToResetPrimaryControllerAfterSwitch()
            })
    }
    
    private func animationValuesToResetPrimaryControllerBeforeSwitch()
    {
        primarySnapshot?.alpha = 1
        primarySnapshot?.transform = .identity
    }
    
    private func animationValuesToHidePrimaryController(primaryTransform: CGAffineTransform) {
        primarySnapshot?.layer.shadowOpacity = 0
        primarySnapshot?.transform = primaryTransform
        secondarySnapshot?.transform = .identity
    }
    
    private func animationValuesToResetPrimaryControllerAfterSwitch()
    {
        primarySnapshot?.removeFromSuperview()
        primarySnapshot = nil
        
        secondarySnapshot?.removeFromSuperview()
        secondarySnapshot = nil
    }
}

// MARK: - Utility

extension ScreenEdgeTabSwitchComponent
{
    private static func makeSnapshotImageView(with controller: UIViewController, shadow: Bool = false) -> UIImageView
    {
        let image = controller.view.snapshot(afterScreenUpdates: false)
        let imageView = UIImageView(image: image)

        if shadow
        {
            imageView.layer.shadowRadius = 30
            imageView.layer.shadowOffset = .init(width: 10, height: 0)
            imageView.layer.shadowOpacity = 1
            imageView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            imageView.layer.masksToBounds = false
            imageView.clipsToBounds = false
        }

        return imageView
    }
    
    private func relativeVelocity(gestureVelocityX: CGFloat, view: UIView) -> CGFloat
    {
        abs(gestureVelocityX / view.bounds.width)
    }
    
    private func secondaryUpdateTransform(delta: GestureData, view: UIView) -> CGAffineTransform
    {
        let offset = (view.bounds.width - abs(delta.x)) / view.bounds.width
        return CGAffineTransform(translationX: offset * 100, y: 0)
    }
    
    private func primaryFinalTransform(with view: UIView) -> CGAffineTransform
    {
        CGAffineTransform(translationX: -view.bounds.width, y: 0)
    }
    
    private func shouldAnimateToSuccessfulTransition(data: GestureData) -> Bool
    {
        (data.x + data.velocityX) < 0
    }
}

// MARK: - Gesture delegate

extension ScreenEdgeTabSwitchComponent: UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        Settings.hideSettings
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        Settings.hideSettings
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        Settings.hideSettings
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        true
    }
}
