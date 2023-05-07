// Copyright Team Seedling ©

import Foundation

class UpdateDayComponent
{
    typealias DayHandler = (_ day: Day) -> Void
    
    var willUpdate: DayHandler
    var didUpdate: DayHandler

    init(willUpdate: @escaping DayHandler, didUpdate: @escaping DayHandler)
    {
        self.willUpdate = willUpdate
        self.didUpdate = didUpdate
        handleNotifications()
    }
    
    func handleNotifications()
    {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(dayProviderWillUpdateDay),
            name: .dayProviderWillUpdateDay,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(dayProviderDidUpdateDay),
            name: .dayProviderDidUpdateDay,
            object: nil)
    }
    
    @objc func dayProviderWillUpdateDay(_ notification: Notification)
    {
        guard let newDay = notification.userInfo?["newDay"] as? Day else { return }
        willUpdate(newDay)
    }
    
    @objc func dayProviderDidUpdateDay(_ notification: Notification)
    {
        guard let day = notification.userInfo?["day"] as? Day else { return }
        didUpdate(day)
    }
    
}
