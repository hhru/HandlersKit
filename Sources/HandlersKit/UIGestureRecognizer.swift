//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

extension HandlersKit where Self: UIGestureRecognizer {

    public init(handler: @escaping (Self) -> Void) {
        self.init()
        onRecognize(handler: handler)
    }

    public init(handler: @escaping () -> Void) {
        self.init()
        onRecognize(handler: handler)
    }

    @discardableResult
    public func onRecognize(handler: @escaping (Self) -> Void) -> Self {
        observer = GestureRecognizerObserver(gestureRecognizer: self, handler: handler)
        return self
    }

    @discardableResult
    public func onRecognize(handler: @escaping () -> Void) -> Self {
        observer = GestureRecognizerObserver(gestureRecognizer: self, handler: { _ in handler() })
        return self
    }
}

private final class GestureRecognizerObserver<T: UIGestureRecognizer>: NSObject {

    private let handler: (T) -> Void

    init(gestureRecognizer: T, handler: @escaping (T) -> Void) {
        self.handler = handler
        super.init()
        gestureRecognizer.addTarget(self, action: #selector(eventHandled(_:)))
    }

    @objc private func eventHandled(_ gestureRecognizer: UIGestureRecognizer) {
        if let gestureRecognizer = gestureRecognizer as? T {
            handler(gestureRecognizer)
        }
    }
}

#endif
