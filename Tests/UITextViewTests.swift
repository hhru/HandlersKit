//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit
import XCTest
@testable import HandlersKit

final class UITextViewTests: XCTestCase {

    func test_shouldBeginEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        var returnedValue: Bool?
        let textView = UITextView()
        textView.shouldBeginEditing { thatTextView in
            handledTextView = thatTextView
            return false
        }

        // when
        returnedValue = textView.delegate?.textViewShouldBeginEditing?(textView)

        // then
        XCTAssert(handledTextView === textView)
        XCTAssert(returnedValue == false)
    }

    func test_shouldBeginEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        let textView = UITextView()
        textView.shouldBeginEditing { false }

        // when
        returnedValue = textView.delegate?.textViewShouldBeginEditing?(textView)

        // then
        XCTAssert(returnedValue == false)
    }

    func test_didBeginEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        let textView = UITextView()
        textView.didBeginEditing { handledTextView = $0 }

        // when
        textView.delegate?.textViewDidBeginEditing?(textView)

        // then
        XCTAssert(handledTextView === textView)
    }

    func test_didBeginEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let textView = UITextView()
        textView.didBeginEditing { isHandled = true }

        // when
        textView.delegate?.textViewDidBeginEditing?(textView)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_shouldEndEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        var returnedValue: Bool?
        let textView = UITextView()
        textView.shouldEndEditing { thatTextView in
            handledTextView = thatTextView
            return false
        }

        // when
        returnedValue = textView.delegate?.textViewShouldEndEditing?(textView)

        // then
        XCTAssert(handledTextView === textView)
        XCTAssert(returnedValue == false)
    }

    func test_shouldEndEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        let textView = UITextView()
        textView.shouldEndEditing { false }

        // when
        returnedValue = textView.delegate?.textViewShouldEndEditing?(textView)

        // then
        XCTAssert(returnedValue == false)
    }

    func test_didEndEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        let textView = UITextView()
        textView.didEndEditing { handledTextView = $0 }

        // when
        textView.delegate?.textViewDidEndEditing?(textView)

        // then
        XCTAssert(handledTextView === textView)
    }

    func test_didEndEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let textView = UITextView()
        textView.didEndEditing { isHandled = true }

        // when
        textView.delegate?.textViewDidEndEditing?(textView)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_shouldChangeTextSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        var returnedValue: Bool?
        var handledValues: (NSRange, String)?
        let textView = UITextView()
        textView.shouldChangeText { thatTextView, range, text in
            handledTextView = thatTextView
            handledValues = (range, text)
            return false
        }

        // when
        returnedValue = textView.delegate?.textView?(
            textView,
            shouldChangeTextIn: NSRange(location: 0, length: 1),
            replacementText: "Text"
        )

        // then
        XCTAssert(handledTextView === textView)
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.1, "Text")
    }

    func test_shouldChangeTextVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        var handledValues: (NSRange, String)?
        let textView = UITextView()
        textView.shouldChangeText { range, text in
            handledValues = (range, text)
            return false
        }

        // when
        returnedValue = textView.delegate?.textView?(
            textView,
            shouldChangeTextIn: NSRange(location: 0, length: 1),
            replacementText: "Text"
        )

        // then
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.1, "Text")
    }

    func test_shouldChangeStringSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        var returnedValue: Bool?
        var handledValues: (String, String)?
        let textView = UITextView()
        textView.shouldChangeString { thatTextView, from, to in
            handledTextView = thatTextView
            handledValues = (from, to)
            return false
        }

        // when
        returnedValue = textView.delegate?.textView?(
            textView,
            shouldChangeTextIn: NSRange(location: 0, length: 0),
            replacementText: "T"
        )

        // then
        XCTAssert(handledTextView === textView)
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, "")
        XCTAssertEqual(handledValues?.1, "T")
    }

    func test_shouldChangeStringVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        var handledValues: (String, String)?
        let textView = UITextView()
        textView.shouldChangeString { from, to in
            handledValues = (from, to)
            return false
        }

        // when
        returnedValue = textView.delegate?.textView?(
            textView,
            shouldChangeTextIn: NSRange(location: 0, length: 0),
            replacementText: "T"
        )

        // then
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, "")
        XCTAssertEqual(handledValues?.1, "T")
    }

    func test_didChangeSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        let textView = UITextView()
        textView.didChange { handledTextView = $0 }

        // when
        textView.delegate?.textViewDidChange?(textView)

        // then
        XCTAssert(handledTextView === textView)
    }

    func test_didChangeVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let textView = UITextView()
        textView.didChange { isHandled = true }

        // when
        textView.delegate?.textViewDidChange?(textView)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_didChangeSelectionSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        let textView = UITextView()
        textView.didChangeSelection { handledTextView = $0 }

        // when
        textView.delegate?.textViewDidChangeSelection?(textView)

        // then
        XCTAssert(handledTextView === textView)
    }

    func test_didChangeSelectionVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let textView = UITextView()
        textView.didChangeSelection { isHandled = true }

        // when
        textView.delegate?.textViewDidChangeSelection?(textView)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_shouldInteractWithURLSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        var returnedValue: Bool?
        var handledValues: (URL, NSRange, UITextItemInteraction)?
        let textView = UITextView()
        textView.shouldInteractWithURL { thatTextView, url, range, item in
            handledTextView = thatTextView
            handledValues = (url, range, item)
            return false
        }

        // when
        returnedValue = textView.delegate?.textView?(
            textView,
            shouldInteractWith: URL(string: "example.com")!,
            in: NSRange(location: 0, length: 1),
            interaction: .preview
        )

        // then
        XCTAssert(handledTextView === textView)
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, URL(string: "example.com")!)
        XCTAssertEqual(handledValues?.1, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.2, .preview)
    }

    func test_shouldInteractWithURLVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        var handledValues: (URL, NSRange, UITextItemInteraction)?
        let textView = UITextView()
        textView.shouldInteractWithURL { url, range, item in
            handledValues = (url, range, item)
            return false
        }

        // when
        returnedValue = textView.delegate?.textView?(
            textView,
            shouldInteractWith: URL(string: "example.com")!,
            in: NSRange(location: 0, length: 1),
            interaction: .preview
        )

        // then
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, URL(string: "example.com")!)
        XCTAssertEqual(handledValues?.1, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.2, .preview)
    }

    func test_shouldInteractWithAttachmentSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextView: UITextView?
        var returnedValue: Bool?
        var handledValues: (NSTextAttachment, NSRange, UITextItemInteraction)?
        let textView = UITextView()
        let textAttachment = NSTextAttachment()
        textView.shouldInteractWithAttachment { thatTextView, attachment, range, item in
            handledTextView = thatTextView
            handledValues = (attachment, range, item)
            return false
        }

        // when
        returnedValue = textView.delegate?.textView?(
            textView,
            shouldInteractWith: textAttachment,
            in: NSRange(location: 0, length: 1),
            interaction: .preview
        )

        // then
        XCTAssert(handledTextView === textView)
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, textAttachment)
        XCTAssertEqual(handledValues?.1, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.2, .preview)
    }

    func test_shouldInteractWithAttachmentVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        var handledValues: (NSTextAttachment, NSRange, UITextItemInteraction)?
        let textView = UITextView()
        let textAttachment = NSTextAttachment()
        textView.shouldInteractWithAttachment { attachment, range, item in
            handledValues = (attachment, range, item)
            return false
        }

        // when
        returnedValue = textView.delegate?.textView?(
            textView,
            shouldInteractWith: textAttachment,
            in: NSRange(location: 0, length: 1),
            interaction: .preview
        )

        // then
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, textAttachment)
        XCTAssertEqual(handledValues?.1, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.2, .preview)
    }

    func test_whenMultipleDelegateEvents_thatAllActionsHandled() {
        // given
        var shouldBeginEditing: Bool?
        var shouldEndEditing: Bool?
        let textView = UITextView()
        textView
            .shouldBeginEditing { false }
            .shouldEndEditing { false }

        // when
        shouldBeginEditing = textView.delegate?.textViewShouldBeginEditing?(textView)
        shouldEndEditing = textView.delegate?.textViewShouldEndEditing?(textView)

        // then
        XCTAssert(shouldBeginEditing == false)
        XCTAssert(shouldEndEditing == false)
    }
}

#endif
