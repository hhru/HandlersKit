//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit
import XCTest
@testable import HandlersKit

final class UIBarButtonItemTests: XCTestCase {

    func test_initWithImageStyleSelfHandler_whenActionSent_thatHandledObjectIsTheSame() {
        // given
        var handledBarButton: UIBarButtonItem?
        let barButton = UIBarButtonItem(image: nil, style: .done) { thatBarButton in
            handledBarButton = thatBarButton
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssert(handledBarButton === barButton)
    }

    func test_initWithImageStyleVoidHandler_whenActionSent_thatActionHandled() {
        // given
        var handled = false
        let barButton = UIBarButtonItem(image: nil, style: .done) {
            handled = true
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssertTrue(handled)
    }

    func test_initWithTitleStyleSelfHandler_whenActionSent_thatHandledObjectIsTheSame() {
        // given
        var handledBarButton: UIBarButtonItem?
        let barButton = UIBarButtonItem(title: "title", style: .done) { thatBarButton in
            handledBarButton = thatBarButton
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssert(handledBarButton === barButton)
    }

    func test_initWithTitleStyleVoidHandler_whenActionSent_thatActionHandled() {
        // given
        var handled = false
        let barButton = UIBarButtonItem(title: "title", style: .done) {
            handled = true
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssertTrue(handled)
    }

    func test_initWithLandscapeImageStyleSelfHandler_whenActionSent_thatHandledObjectIsTheSame() {
        // given
        var handledBarButton: UIBarButtonItem?
        let barButton = UIBarButtonItem(image: nil, landscapeImagePhone: nil, style: .done) { thatBarButton in
            handledBarButton = thatBarButton
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssert(handledBarButton === barButton)
    }

    func test_initWithLandscapeImageStyleVoidHandler_whenActionSent_thatActionHandled() {
        // given
        var handled = false
        let barButton = UIBarButtonItem(image: nil, landscapeImagePhone: nil, style: .done) {
            handled = true
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssertTrue(handled)
    }

    func test_initWithBarButtonSystemItemSelfHandler_whenActionSent_thatHandledObjectIsTheSame() {
        // given
        var handledBarButton: UIBarButtonItem?
        let barButton = UIBarButtonItem(barButtonSystemItem: .done) { thatBarButton in
            handledBarButton = thatBarButton
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssert(handledBarButton === barButton)
    }

    func test_initWithBarButtonSystemItemVoidHandler_whenActionSent_thatActionHandled() {
        // given
        var handled = false
        let barButton = UIBarButtonItem(barButtonSystemItem: .done) {
            handled = true
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssertTrue(handled)
    }

    func test_onTapSelfHandler_whenActionSent_thatHandledObjectIsTheSame() {
        // given
        var handledBarButton: UIBarButtonItem?
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        barButton.onTap { thatBarButton in
            handledBarButton = thatBarButton
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssert(handledBarButton === barButton)
    }

    func test_onTapVoidHandler_whenActionSent_thatActionHandled() {
        // given
        var handled = false
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        barButton.onTap {
            handled = true
        }

        // when
        _ = barButton.target?.perform(barButton.action, with: barButton)

        // then
        XCTAssertTrue(handled)
    }
}

#endif
