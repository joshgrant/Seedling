// Copyright Team Seedling ©

import Foundation

protocol StateMachine
{
    associatedtype State
    
    func canTransition(to newState: State) -> Bool
    func transition(to newState: State)
    func didTransition(to state: State)
}
