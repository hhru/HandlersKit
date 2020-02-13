//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

import Foundation

protocol EventsObserverHolder: AnyObject {

    var eventsObserver: [UInt: Any] { get set }
}

private var observerAssociatedKey: UInt8 = 0

extension EventsObserverHolder {

    var eventsObserver: [UInt: Any] {
        get {
            objc_getAssociatedObject(self, &observerAssociatedKey) as? [UInt: Any] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &observerAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
