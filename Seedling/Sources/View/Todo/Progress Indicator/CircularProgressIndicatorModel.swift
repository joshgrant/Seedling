// Copyright Team Seedling ©

import Foundation

class CircularProgressIndicatorModel: ObservableObject
{
    // MARK: - Types
    
    enum Constants
    {
        static let initialAngle: Double = -90
        static let resetAngle: Double = 0
        static let maxAngle: Double = 270
    }
    
    // MARK: - Variables
    
    @Published var endAngle: Double = Constants.initialAngle
    {
        didSet { didUpdate(angle: endAngle) }
    }
    
    // TODO: Have the scroll view delegate communicate `didEndScrolling` to the
    // progress indicator to reset the state
    var currentState: State = .inactive
    var didTransition: ((State) -> Void)?
    
    // MARK: - Initialization
    
    init(didTransition: ((State) -> Void)? = nil)
    {
        self.didTransition = didTransition
    }
    
    // MARK: - Functions
    
    private func didUpdate(angle: CGFloat)
    {
        switch (currentState, angle)
        {
        case (.inactive, let x) where x > Constants.resetAngle:
            transition(to: .pulling)
        case (.pulling, let x) where x < Constants.resetAngle:
            transition(to: .inactive)
        case (.pulling, let x) where x >= Constants.maxAngle:
            transition(to: .animatingCheckmark)
            transition(to: .complete)
        case (.complete, let x) where x <= Constants.resetAngle:
            transition(to: .inactive)
        default:
            break
        }
    }
}

extension CircularProgressIndicatorModel: StateMachine
{
    enum State
    {
        case inactive
        case pulling
        case animatingCheckmark
        case complete
    }
    
    func canTransition(to newState: State) -> Bool
    {
        switch (currentState, newState)
        {
        case (.inactive, .pulling):
            return true
        case (.pulling, .animatingCheckmark):
            return true
        case (.animatingCheckmark, .complete):
            return true
        case (.complete, .inactive), (.pulling, .inactive):
            return true
        default:
            return false
        }
    }
    
    func transition(to newState: State)
    {
        guard canTransition(to: newState) else { return }
        currentState = newState
        didTransition(to: currentState)
    }
    
    func didTransition(to state: State)
    {
        print("Did transition to: \(state)")
        didTransition?(state)
    }
}
