//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

extension HandlersKit where Self: UITextView {

    @discardableResult
    public func shouldBeginEditing(handler: @escaping (Self) -> Bool) -> Self {
        updateObserver { $0.shouldBeginEditing = handler }
    }

    @discardableResult
    public func shouldBeginEditing(handler: @escaping () -> Bool) -> Self {
        shouldBeginEditing { _ in handler() }
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
    public func didBeginEditing(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didBeginEditing = handler }
    }

    @discardableResult
    public func didBeginEditing(handler: @escaping () -> Void) -> Self {
        didBeginEditing { _ in handler() }
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
    public func shouldChangeText(handler: @escaping (Self, NSRange, String) -> Bool) -> Self {
        updateObserver { $0.shouldChangeText = handler }
    }

    @discardableResult
    public func shouldChangeText(handler: @escaping (NSRange, String) -> Bool) -> Self {
        shouldChangeText { handler($1, $2) }
    }

    @discardableResult
    public func shouldChangeString(
        handler: @escaping (_ textView: Self, _ from: String, _ to: String) -> Bool
    ) -> Self {
        shouldChangeText { textView, range, string in
            let text = textView.text ?? ""
            let newText = NSString(string: text).replacingCharacters(in: range, with: string)
            return handler(textView, text, newText)
        }
    }

    @discardableResult
    public func shouldChangeString(handler: @escaping (_ from: String, _ to: String) -> Bool) -> Self {
        shouldChangeString { handler($1, $2) }
    }

    @discardableResult
    public func didChange(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didChange = handler }
    }

    @discardableResult
    public func didChange(handler: @escaping () -> Void) -> Self {
        didChange { _ in handler() }
    }

    @discardableResult
    public func didChangeSelection(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didChangeSelection = handler }
    }

    @discardableResult
    public func didChangeSelection(handler: @escaping () -> Void) -> Self {
        didChangeSelection { _ in handler() }
    }

    @discardableResult
    public func shouldInteractWithURL(handler: @escaping (Self, URL, NSRange, UITextItemInteraction) -> Bool) -> Self {
        updateObserver { $0.shouldInteractWithURL = handler }
    }

    @discardableResult
    public func shouldInteractWithURL(handler: @escaping (URL, NSRange, UITextItemInteraction) -> Bool) -> Self {
        shouldInteractWithURL { handler($1, $2, $3) }
    }

    @discardableResult
    public func shouldInteractWithAttachment(
        handler: @escaping (Self, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool
    ) -> Self {
        updateObserver { $0.shouldInteractWithAttachment = handler }
    }

    @discardableResult
    public func shouldInteractWithAttachment(
        handler: @escaping (NSTextAttachment, NSRange, UITextItemInteraction) -> Bool
    ) -> Self {
        shouldInteractWithAttachment { handler($1, $2, $3) }
    }

    private func updateObserver(_ update: (TextViewObserver<Self>) -> Void) -> Self {
        if let textViewObserver = observer as? TextViewObserver<Self> {
            update(textViewObserver)
        } else {
            let textViewObserver = TextViewObserver(textView: self)
            update(textViewObserver)
            observer = textViewObserver
        }
        return self
    }
}

private final class TextViewObserver<T: UITextView>: NSObject, UITextViewDelegate {

    var shouldBeginEditing: ((T) -> Bool)?
    var shouldEndEditing: ((T) -> Bool)?
    var didBeginEditing: ((T) -> Void)?
    var didEndEditing: ((T) -> Void)?
    var shouldChangeText: ((T, NSRange, String) -> Bool)?
    var didChange: ((T) -> Void)?
    var didChangeSelection: ((T) -> Void)?
    var shouldInteractWithURL: ((T, URL, NSRange, UITextItemInteraction) -> Bool)?
    var shouldInteractWithAttachment: ((T, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?

    init(textView: T) {
        super.init()
        textView.delegate = self
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        guard let textView = textView as? T, let shouldBeginEditing = shouldBeginEditing else {
            return true
        }
        return shouldBeginEditing(textView)
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        guard let textView = textView as? T, let shouldEndEditing = shouldEndEditing else {
            return true
        }
        return shouldEndEditing(textView)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let textView = textView as? T else {
            return
        }
        didBeginEditing?(textView)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard let textView = textView as? T else {
            return
        }
        didEndEditing?(textView)
    }

    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        guard let textView = textView as? T, let shouldChangeText = shouldChangeText else {
            return true
        }
        return shouldChangeText(textView, range, text)
    }

    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? T else {
            return
        }
        didChange?(textView)
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        guard let textView = textView as? T else {
            return
        }
        didChangeSelection?(textView)
    }

    func textView(
        _ textView: UITextView,
        shouldInteractWith URL: URL,
        in characterRange: NSRange,
        interaction: UITextItemInteraction
    ) -> Bool {
        guard let textView = textView as? T, let shouldInteractWithURL = shouldInteractWithURL else {
            return true
        }
        return shouldInteractWithURL(textView, URL, characterRange, interaction)
    }

    func textView(
        _ textView: UITextView,
        shouldInteractWith textAttachment: NSTextAttachment,
        in characterRange: NSRange,
        interaction: UITextItemInteraction
    ) -> Bool {
        guard let textView = textView as? T, let shouldInteractWithAttachment = shouldInteractWithAttachment else {
            return true
        }
        return shouldInteractWithAttachment(textView, textAttachment, characterRange, interaction)
    }
}

#endif
