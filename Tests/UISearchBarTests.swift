//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit
import XCTest
@testable import HandlersKit

final class UISearchBarTests: XCTestCase {

    func test_shouldBeginEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledSearchBar: UISearchBar?
        var returnedValue: Bool?
        let searchBar = UISearchBar()
        searchBar.shouldBeginEditing { thatsearchBar in
            handledSearchBar = thatsearchBar
            return false
        }

        // when
        returnedValue = searchBar.delegate?.searchBarShouldBeginEditing?(searchBar)

        // then
        XCTAssert(handledSearchBar === searchBar)
        XCTAssert(returnedValue == false)
    }

    func test_shouldBeginEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        let searchBar = UISearchBar()
        searchBar.shouldBeginEditing { false }

        // when
        returnedValue = searchBar.delegate?.searchBarShouldBeginEditing?(searchBar)

        // then
        XCTAssert(returnedValue == false)
    }

    func test_didBeginEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledSearchBar: UISearchBar?
        let searchBar = UISearchBar()
        searchBar.didBeginEditing { handledSearchBar = $0 }

        // when
        searchBar.delegate?.searchBarTextDidBeginEditing?(searchBar)

        // then
        XCTAssert(handledSearchBar === searchBar)
    }

    func test_didBeginEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let searchBar = UISearchBar()
        searchBar.didBeginEditing { isHandled = true }

        // when
        searchBar.delegate?.searchBarTextDidBeginEditing?(searchBar)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_shouldEndEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledSearchBar: UISearchBar?
        var returnedValue: Bool?
        let searchBar = UISearchBar()
        searchBar.shouldEndEditing { thatsearchBar in
            handledSearchBar = thatsearchBar
            return false
        }

        // when
        returnedValue = searchBar.delegate?.searchBarShouldEndEditing?(searchBar)

        // then
        XCTAssert(handledSearchBar === searchBar)
        XCTAssert(returnedValue == false)
    }

    func test_shouldEndEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var returnedValue: Bool?
        let searchBar = UISearchBar()
        searchBar.shouldEndEditing { false }

        // when
        returnedValue = searchBar.delegate?.searchBarShouldEndEditing?(searchBar)

        // then
        XCTAssert(returnedValue == false)
    }

    func test_didEndEditingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledSearchBar: UISearchBar?
        let searchBar = UISearchBar()
        searchBar.didEndEditing { handledSearchBar = $0 }

        // when
        searchBar.delegate?.searchBarTextDidEndEditing?(searchBar)

        // then
        XCTAssert(handledSearchBar === searchBar)
    }

    func test_didEndEditingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let searchBar = UISearchBar()
        searchBar.didEndEditing { isHandled = true }

        // when
        searchBar.delegate?.searchBarTextDidEndEditing?(searchBar)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_textDidChangeSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledSearchBar: UISearchBar?
        var handledText: String?

        let searchBar = UISearchBar()
        let expectedText = "Text"

        searchBar.textDidChange { searchBar, text in
            handledSearchBar = searchBar
            handledText = text
        }

        // when
        searchBar.delegate?.searchBar?(searchBar, textDidChange: expectedText)

        // then
        XCTAssert(handledSearchBar === searchBar)
        XCTAssertEqual(expectedText, handledText)
    }

    func test_textDidChangeVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledText: String?

        let searchBar = UISearchBar()
        let expectedText = "Text"

        searchBar.textDidChange { text in
            handledText = text
        }

        // when
        searchBar.delegate?.searchBar?(searchBar, textDidChange: expectedText)

        // then
        XCTAssertEqual(expectedText, handledText)
    }

    func test_shouldChangeTextSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledSearchBar: UISearchBar?
        var handledValues: (NSRange, String)?
        var returnedValue: Bool?
        let searchBar = UISearchBar()
        searchBar.shouldChangeText { thatsearchBar, range, text in
            handledSearchBar = thatsearchBar
            handledValues = (range, text)
            return false
        }

        // when
        returnedValue = searchBar.delegate?.searchBar?(
            searchBar,
            shouldChangeTextIn: NSRange(location: 0, length: 1),
            replacementText: "Text"
        )

        // then
        XCTAssert(handledSearchBar === searchBar)
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.1, "Text")
    }

    func test_shouldChangeTextVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledValues: (NSRange, String)?
        var returnedValue: Bool?
        let searchBar = UISearchBar()
        searchBar.shouldChangeText { range, text in
            handledValues = (range, text)
            return false
        }

        // when
        returnedValue = searchBar.delegate?.searchBar?(
            searchBar,
            shouldChangeTextIn: NSRange(location: 0, length: 1),
            replacementText: "Text"
        )

        // then
        XCTAssert(returnedValue == false)
        XCTAssertEqual(handledValues?.0, NSRange(location: 0, length: 1))
        XCTAssertEqual(handledValues?.1, "Text")
    }

    func test_searchButtonClickSelfHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledSearchBar: UISearchBar?
        let searchBar = UISearchBar()

        searchBar.searchButtonClicked { searchBar in
            handledSearchBar = searchBar
        }

        // when
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)

        // then
        XCTAssert(handledSearchBar === searchBar)
    }

    func test_searchButtonClickVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isSearchButtonClickedCalled = false
        let searchBar = UISearchBar()

        searchBar.searchButtonClicked {
            isSearchButtonClickedCalled = true
        }

        // when
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)

        // then
        XCTAssertTrue(isSearchButtonClickedCalled)
    }

    func test_bookmarkButtonClickSelfHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledSearchBar: UISearchBar?
        let searchBar = UISearchBar()

        searchBar.bookmarkButtonClicked { searchBar in
            handledSearchBar = searchBar
        }

        // when
        searchBar.delegate?.searchBarBookmarkButtonClicked?(searchBar)

        // then
        XCTAssert(handledSearchBar === searchBar)
    }

    func test_bookmarkButtonClickVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isBookmarkButtonClickedCalled = false
        let searchBar = UISearchBar()

        searchBar.bookmarkButtonClicked {
            isBookmarkButtonClickedCalled = true
        }

        // when
        searchBar.delegate?.searchBarBookmarkButtonClicked?(searchBar)

        // then
        XCTAssertTrue(isBookmarkButtonClickedCalled)
    }

    func test_cancelButtonClickSelfHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledSearchBar: UISearchBar?
        let searchBar = UISearchBar()

        searchBar.cancelButtonClicked { searchBar in
            handledSearchBar = searchBar
        }

        // when
        searchBar.delegate?.searchBarCancelButtonClicked?(searchBar)

        // then
        XCTAssert(handledSearchBar === searchBar)
    }

    func test_cancelButtonClickVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isCancelButtonClickedCalled = false
        let searchBar = UISearchBar()

        searchBar.cancelButtonClicked {
            isCancelButtonClickedCalled = true
        }

        // when
        searchBar.delegate?.searchBarCancelButtonClicked?(searchBar)

        // then
        XCTAssertTrue(isCancelButtonClickedCalled)
    }

    func test_resultsListlButtonClickSelfHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledSearchBar: UISearchBar?
        let searchBar = UISearchBar()

        searchBar.resultsListButtonClicked { searchBar in
            handledSearchBar = searchBar
        }

        // when
        searchBar.delegate?.searchBarResultsListButtonClicked?(searchBar)

        // then
        XCTAssert(handledSearchBar === searchBar)
    }

    func test_resultsListButtonClickVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isResultsListButtonClickedCalled = false
        let searchBar = UISearchBar()

        searchBar.resultsListButtonClicked {
            isResultsListButtonClickedCalled = true
        }

        // when
        searchBar.delegate?.searchBarResultsListButtonClicked?(searchBar)

        // then
        XCTAssertTrue(isResultsListButtonClickedCalled)
    }

    func test_selectedScopeButtonIndexDidChangeSelfHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledSearchBar: UISearchBar?
        var handledIndex: Int?

        let searchBar = UISearchBar()
        let expectedIndex = 2

        searchBar.selectedScopeButtonIndexDidChange { searchBar, index in
            handledSearchBar = searchBar
            handledIndex = index
        }

        // when
        searchBar.delegate?.searchBar?(searchBar, selectedScopeButtonIndexDidChange: expectedIndex)

        // then
        XCTAssert(searchBar === handledSearchBar)
        XCTAssertEqual(expectedIndex, handledIndex)
    }

    func test_selectedScopeButtonIndexDidChangeVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var handledIndex: Int?

        let searchBar = UISearchBar()
        let expectedIndex = 2

        searchBar.selectedScopeButtonIndexDidChange { index in
            handledIndex = index
        }

        // when
        searchBar.delegate?.searchBar?(searchBar, selectedScopeButtonIndexDidChange: expectedIndex)

        // then
        XCTAssertEqual(expectedIndex, handledIndex)
    }

    func test_whenMultipleDelegateEvents_thatAllActionsHandled() {
        // given
        var shouldChangeText: Bool?
        var shouldEndEditing: Bool?
        let searchBar = UISearchBar()

        searchBar
            .shouldChangeText { _, _ in
                false
            }
            .shouldEndEditing { false }

        // when
        shouldChangeText = searchBar
            .delegate?
            .searchBar?(searchBar, shouldChangeTextIn: NSRange(), replacementText: "Text")

        shouldEndEditing = searchBar
            .delegate?
            .searchBarShouldEndEditing?(searchBar)

        // then
        XCTAssert(shouldChangeText == false)
        XCTAssert(shouldEndEditing == false)
    }
}

#endif
