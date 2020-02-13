//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

extension HandlersKit where Self: UIBarButtonItem {

    public init(image: UIImage?, style: UIBarButtonItem.Style, handler: @escaping (Self) -> Void) {
        self.init(image: image, style: style, target: nil, action: nil)
        onTap(handler: handler)
    }

    public init(image: UIImage?, style: UIBarButtonItem.Style, handler: @escaping () -> Void) {
        self.init(image: image, style: style, target: nil, action: nil)
        onTap(handler: handler)
    }

    public init(title: String?, style: UIBarButtonItem.Style, handler: @escaping (Self) -> Void) {
        self.init(title: title, style: style, target: nil, action: nil)
        onTap(handler: handler)
    }

    public init(title: String?, style: UIBarButtonItem.Style, handler: @escaping () -> Void) {
        self.init(title: title, style: style, target: nil, action: nil)
        onTap(handler: handler)
    }

    public init(
        image: UIImage?,
        landscapeImagePhone: UIImage?,
        style: UIBarButtonItem.Style,
        handler: @escaping (Self) -> Void
    ) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        onTap(handler: handler)
    }

    public init(
        image: UIImage?,
        landscapeImagePhone: UIImage?,
        style: UIBarButtonItem.Style,
        handler: @escaping () -> Void
    ) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        onTap(handler: handler)
    }

    public init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, handler: @escaping (Self) -> Void) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        onTap(handler: handler)
    }

    public init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, handler: @escaping () -> Void) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        onTap(handler: handler)
    }

    @discardableResult
    public func onTap(handler: @escaping (Self) -> Void) -> Self {
        observer = BarButtonItemObserver(barButtonItem: self, handler: handler)
        return self
    }

    @discardableResult
    public func onTap(handler: @escaping () -> Void) -> Self {
        observer = BarButtonItemObserver(barButtonItem: self, handler: { _ in handler() })
        return self
    }
}

private final class BarButtonItemObserver<T: UIBarButtonItem>: NSObject {

    private let handler: (T) -> Void

    init(barButtonItem: T, handler: @escaping (T) -> Void) {
        self.handler = handler
        super.init()
        barButtonItem.target = self
        barButtonItem.action = #selector(eventHandled(_:))
    }

    @objc private func eventHandled(_ sender: UIBarButtonItem) {
        if let sender = sender as? T {
            handler(sender)
        }
    }
}

#endif
