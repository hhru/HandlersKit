//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

extension HandlersKit where Self: UITextField {

    @discardableResult
    public func shouldBeginEditing(handler: @escaping (Self) -> Bool) -> Self {
        updateObserver { $0.shouldBeginEditing = handler }
    }

    @discardableResult
    public func shouldBeginEditing(handler: @escaping () -> Bool) -> Self {
        shouldBeginEditing { _ in handler() }
    }

    @discardableResult
    public func didBeginEditing(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didBeginEditing = handler }
    }

    @discardableResult
    public func didBeginEditing(handler: @escaping () -> Void) -> Self {
        didBeginEditing { _ in handler() }
    }

    @discardableResult
    public func shouldEndEditing(handler: @escaping (Self) -> Bool) -> Self {
        updateObserver { $0.shouldEndEditing = handler }
    }

    @discardableResult
    public func shouldEndEditing(handler: @escaping () -> Bool) -> Self {
        shouldEndEditing { _ in handler() }
    }

    @discardableResult
    public func didEndEditing(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didEndEditing = handler }
    }

    @discardableResult
    public func didEndEditing(handler: @escaping () -> Void) -> Self {
        didEndEditing { _ in handler() }
    }

    @discardableResult
    public func shouldChangeCharacters(handler: @escaping (Self, NSRange, String) -> Bool) -> Self {
        updateObserver { $0.shouldChangeCharacters = handler }
    }

    @discardableResult
    public func shouldChangeCharacters(handler: @escaping (NSRange, String) -> Bool) -> Self {
        shouldChangeCharacters { handler($1, $2) }
    }

    @discardableResult
    public func shouldChangeString(
        handler: @escaping (_ textField: Self, _ from: String, _ to: String) -> Bool
    ) -> Self {
        shouldChangeCharacters { textField, range, string in
            let text = textField.text ?? ""
            let newText = NSString(string: text).replacingCharacters(in: range, with: string)
            return handler(textField, text, newText)
        }
    }

    @discardableResult
    public func shouldChangeString(handler: @escaping (_ from: String, _ to: String) -> Bool) -> Self {
        shouldChangeString { handler($1, $2) }
    }

    @discardableResult
    public func shouldClear(handler: @escaping (Self) -> Bool) -> Self {
        updateObserver { $0.shouldClear = handler }
    }

    @discardableResult
    public func shouldClear(handler: @escaping () -> Bool) -> Self {
        shouldClear { _ in handler() }
    }

    @discardableResult
    public func shouldReturn(handler: @escaping (Self) -> Bool) -> Self {
        updateObserver { $0.shouldReturn = handler }
    }

    @discardableResult
    public func shouldReturn(handler: @escaping () -> Bool) -> Self {
        shouldReturn { _ in handler() }
    }

    private func updateObserver(_ update: (TextFieldObserver<Self>) -> Void) -> Self {
        if let textFieldObserver = observer as? TextFieldObserver<Self> {
            update(textFieldObserver)
        } else {
            let textFieldObserver = TextFieldObserver(textField: self)
            update(textFieldObserver)
            observer = textFieldObserver
        }
        return self
    }
}

private final class TextFieldObserver<T: UITextField>: NSObject, UITextFieldDelegate {

    var shouldBeginEditing: ((T) -> Bool)?
    var didBeginEditing: ((T) -> Void)?
    var shouldEndEditing: ((T) -> Bool)?
    var didEndEditing: ((T) -> Void)?
    var shouldChangeCharacters: ((T, _ range: NSRange, _ replacementString: String) -> Bool)?
    var shouldClear: ((T) -> Bool)?
    var shouldReturn: ((T) -> Bool)?

    init(textField: T) {
        super.init()
        textField.delegate = self
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let textField = textField as? T, let shouldBeginEditing = shouldBeginEditing else {
            return true
        }
        return shouldBeginEditing(textField)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? T else {
            return
        }
        didBeginEditing?(textField)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let textField = textField as? T, let shouldEndEditing = shouldEndEditing else {
            return true
        }
        return shouldEndEditing(textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? T else {
            return
        }
        didEndEditing?(textField)
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let textField = textField as? T, let shouldChangeCharacters = shouldChangeCharacters else {
            return true
        }
        return shouldChangeCharacters(textField, range, string)
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        guard let textField = textField as? T, let shouldClear = shouldClear else {
            return true
        }
        return shouldClear(textField)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textField = textField as? T, let shouldReturn = shouldReturn else {
            return true
        }
        return shouldReturn(textField)
    }
}

#endif
