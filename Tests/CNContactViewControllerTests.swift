//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit) && canImport(ContactsUI)
import UIKit
import ContactsUI
import XCTest
@testable import HandlersKit

final class CNContactViewControllerTests: XCTestCase {

    func test_didFinishSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledContact: CNContact?
        let contactViewController = CNContactViewController()
        let expectedContact = CNContact()

        contactViewController.didFinish { contact in
            handledContact = contact
        }

        // when
        contactViewController.delegate?.contactViewController?(contactViewController, didCompleteWith: expectedContact)

        // than
        XCTAssertEqual(handledContact, expectedContact)
    }

    func test_didFinishSelfHandlerTwice_whenDelegateTriggered_thenHandledOnlyOnce() {
        var actualCallCount = 0

        let contactViewController = CNContactViewController()
        let expectedCallCount = 1

        contactViewController
            .didFinish { _ in
                actualCallCount += 1
            }.didFinish { _ in
                actualCallCount += 1
            }

        // when
        contactViewController.delegate?.contactViewController?(contactViewController, didCompleteWith: CNContact())

        // than
        XCTAssertEqual(expectedCallCount, actualCallCount)
    }
}

#endif
