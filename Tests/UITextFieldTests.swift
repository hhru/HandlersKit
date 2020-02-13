//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit
import XCTest
@testable import HandlersKit

final class UITextFieldTests: XCTestCase {

    func test_shouldBeginEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextField: UITextField?
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldBeginEditing { thatTextField in
            handledTextField = thatTextField
            return false
        }

        // when
        returnedValue = textField.delegate?.textFieldShouldBeginEditing?(textField)

        // then
        XCTAssert(handledTextField === textField)
        XCTAssert(returnedValue == false)
    }

    func test_shouldBeginEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldBeginEditing { false }

        // when
        returnedValue = textField.delegate?.textFieldShouldBeginEditing?(textField)

        // then
        XCTAssert(returnedValue == false)
    }

    func test_didBeginEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextField: UITextField?
        let textField = UITextField()
        textField.didBeginEditing { handledTextField = $0 }

        // when
        textField.delegate?.textFieldDidBeginEditing?(textField)

        // then
        XCTAssert(handledTextField === textField)
    }

    func test_didBeginEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let textField = UITextField()
        textField.didBeginEditing { isHandled = true }

        // when
        textField.delegate?.textFieldDidBeginEditing?(textField)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_shouldEndEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextField: UITextField?
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldEndEditing { thatTextField in
            handledTextField = thatTextField
            return false
        }

        // when
        returnedValue = textField.delegate?.textFieldShouldEndEditing?(textField)

        // then
        XCTAssert(handledTextField === textField)
        XCTAssert(returnedValue == false)
    }

    func test_shouldEndEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldEndEditing { false }

        // when
        returnedValue = textField.delegate?.textFieldShouldEndEditing?(textField)

        // then
        XCTAssert(returnedValue == false)
    }

    func test_didEndEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextField: UITextField?
        let textField = UITextField()
        textField.didEndEditing { handledTextField = $0 }

        // when
        textField.delegate?.textFieldDidEndEditing?(textField)

        // then
        XCTAssert(handledTextField === textField)
    }

    func test_didEndEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let textField = UITextField()
        textField.didEndEditing { isHandled = true }

        // when
        textField.delegate?.textFieldDidEndEditing?(textField)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_shouldChangeCharactersSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextField: UITextField?
        var handledValues: (NSRange, String)?
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldChangeCharacters { thatTextField, range, text in
            handledTextField = thatTextField
            handledValues = (range, text)
            return false
        }

        // when
        returnedValue = textField.delegate?.textField?(
            textField,
            shouldChangeCharactersIn: NSRange(location: 0, length: 1),
            replacementString: "Text"
        )

        // then
        XCTAssert(handledTextField === textField)
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.1, "Text")
    }

    func test_shouldChangeCharactersVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledValues: (NSRange, String)?
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldChangeCharacters { range, text in
            handledValues = (range, text)
            return false
        }

        // when
        returnedValue = textField.delegate?.textField?(
            textField,
            shouldChangeCharactersIn: NSRange(location: 0, length: 1),
            replacementString: "Text"
        )

        // then
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.1, "Text")
    }

    func test_shouldChangeStringSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextField: UITextField?
        var handledValues: (String, String)?
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldChangeString { thatTextField, from, to in
            handledTextField = thatTextField
            handledValues = (from, to)
            return false
        }

        // when
        returnedValue = textField.delegate?.textField?(
            textField,
            shouldChangeCharactersIn: NSRange(location: 0, length: 0),
            replacementString: "T"
        )

        // then
        XCTAssert(handledTextField === textField)
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, "")
        XCTAssertEqual(handledValues?.1, "T")
    }

    func test_shouldChangeStringVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledValues: (String, String)?
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldChangeString { from, to in
            handledValues = (from, to)
            return false
        }

        // when
        returnedValue = textField.delegate?.textField?(
            textField,
            shouldChangeCharactersIn: NSRange(location: 0, length: 0),
            replacementString: "T"
        )

        // then
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, "")
        XCTAssertEqual(handledValues?.1, "T")
    }

    func test_shouldClearSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextField: UITextField?
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldClear { thatTextField in
            handledTextField = thatTextField
            return false
        }

        // when
        returnedValue = textField.delegate?.textFieldShouldClear?(textField)

        // then
        XCTAssert(handledTextField === textField)
        XCTAssert(returnedValue == false)
    }

    func test_shouldClearVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldClear { false }

        // when
        returnedValue = textField.delegate?.textFieldShouldClear?(textField)

        // then
        XCTAssert(returnedValue == false)
    }

    func test_shouldReturnSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledTextField: UITextField?
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldReturn { thatTextField in
            handledTextField = thatTextField
            return false
        }

        // when
        returnedValue = textField.delegate?.textFieldShouldReturn?(textField)

        // then
        XCTAssert(handledTextField === textField)
        XCTAssert(returnedValue == false)
    }

    func test_shouldReturnVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        let textField = UITextField()
        textField.shouldReturn { false }

        // when
        returnedValue = textField.delegate?.textFieldShouldReturn?(textField)

        // then
        XCTAssert(returnedValue == false)
    }

    func test_whenSentBothActionAndDelegateEvents_thatAllActionsHandled() {
        // given
        var returnedValue: Bool?
        var isEditingDidEndHandled: Bool?
        let textField = UITextField()
        textField
            .shouldReturn { false }
            .on(.editingDidEnd, handler: { isEditingDidEndHandled = true })

        // when
        returnedValue = textField.delegate?.textFieldShouldReturn?(textField)
        textField.sendActionsWithSelf(for: .editingDidEnd)

        // then
        XCTAssert(returnedValue == false)
        XCTAssert(isEditingDidEndHandled == true)
    }

    func test_whenMultipleDelegateEvents_thatAllActionsHandled() {
        // given
        var shouldReturn: Bool?
        var shouldClear: Bool?
        let textField = UITextField()
        textField
            .shouldReturn { false }
            .shouldClear { false }

        // when
        shouldReturn = textField.delegate?.textFieldShouldReturn?(textField)
        shouldClear = textField.delegate?.textFieldShouldClear?(textField)

        // then
        XCTAssert(shouldReturn == false)
        XCTAssert(shouldClear == false)
    }
}

#endif
