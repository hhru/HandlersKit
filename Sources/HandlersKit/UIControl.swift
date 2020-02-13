//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

extension HandlersKit where Self: UIControl {

    @discardableResult
    public func on(_ event: UIControl.Event, handler: @escaping (Self) -> Void) -> Self {
        let observer = EventObserver(control: self, event: event, handler: handler)
        eventsObserver[event.rawValue] = observer
        return self
    }

    @discardableResult
    public func on(_ event: UIControl.Event, handler: @escaping () -> Void) -> Self {
        let observer = EventObserver(control: self, event: event, handler: { _ in handler() })
        eventsObserver[event.rawValue] = observer
        return self
    }
}

extension HandlersKit where Self: UIButton {

    @discardableResult
    public func onTap(handler: @escaping (Self) -> Void) -> Self {
        return on(.touchUpInside, handler: handler)
    }

    @discardableResult
    public func onTap(handler: @escaping () -> Void) -> Self {
        return on(.touchUpInside, handler: handler)
    }
}

extension HandlersKit where Self: UISwitch {

    @discardableResult
    public func onChange(handler: @escaping (Self, Bool) -> Void) -> Self {
        return on(.valueChanged) { handler($0, $0.isOn) }
    }

    @discardableResult
    public func onChange(handler: @escaping (Bool) -> Void) -> Self {
        return on(.valueChanged) { handler($0.isOn) }
    }
}

extension HandlersKit where Self: UISlider {

    @discardableResult
    public func onChange(handler: @escaping (Self, Float) -> Void) -> Self {
        return on(.valueChanged) { handler($0, $0.value) }
    }

    @discardableResult
    public func onChange(handler: @escaping (Float) -> Void) -> Self {
        return on(.valueChanged) { handler($0.value) }
    }
}

extension HandlersKit where Self: UISegmentedControl {

    @discardableResult
    public func onChange(handler: @escaping (Self, Int) -> Void) -> Self {
        return on(.valueChanged) { handler($0, $0.selectedSegmentIndex) }
    }

    @discardableResult
    public func onChange(handler: @escaping (Int) -> Void) -> Self {
        return on(.valueChanged) { handler($0.selectedSegmentIndex) }
    }
}

extension HandlersKit where Self: UIStepper {

    @discardableResult
    public func onChange(handler: @escaping (Self, Double) -> Void) -> Self {
        return on(.valueChanged) { handler($0, $0.value) }
    }

    @discardableResult
    public func onChange(handler: @escaping (Double) -> Void) -> Self {
        return on(.valueChanged) { handler($0.value) }
    }
}

extension HandlersKit where Self: UIPageControl {

    @discardableResult
    public func onChange(handler: @escaping (Self, Int) -> Void) -> Self {
        return on(.valueChanged) { handler($0, $0.currentPage) }
    }

    @discardableResult
    public func onChange(handler: @escaping (Int) -> Void) -> Self {
        return on(.valueChanged) { handler($0.currentPage) }
    }
}

extension HandlersKit where Self: UIDatePicker {

    @discardableResult
    public func onChange(handler: @escaping (Self, Date) -> Void) -> Self {
        return on(.valueChanged) { handler($0, $0.date) }
    }

    @discardableResult
    public func onChange(handler: @escaping (Date) -> Void) -> Self {
        return on(.valueChanged) { handler($0.date) }
    }
}

private final class EventObserver<T: UIControl>: NSObject {

    private let handler: (T) -> Void

    init(control: T, event: UIControl.Event, handler: @escaping (T) -> Void) {
        self.handler = handler
        super.init()
        control.addTarget(self, action: #selector(eventHandled(_:)), for: event)
    }

    @objc private func eventHandled(_ sender: UIControl) {
        if let sender = sender as? T {
            handler(sender)
        }
    }
}

#endif
