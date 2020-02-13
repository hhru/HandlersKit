//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

import Foundation

protocol ObserverHolder: AnyObject {

    var observer: Any? { get set }
}

private var observerAssociatedKey: UInt8 = 0

extension ObserverHolder {

    var observer: Any? {
        get {
            objc_getAssociatedObject(self, &observerAssociatedKey)
        }
        set {
            objc_setAssociatedObject(self, &observerAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
