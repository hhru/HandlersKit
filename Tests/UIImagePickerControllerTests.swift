//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit) && canImport(ContactsUI)
import UIKit
import XCTest
@testable import HandlersKit

final class UIImagePickerViewControllerTests: XCTestCase {

    func test_didFinishPickingMediaSelfHandler_whenDelegateTriggered_thaHandledObjectIsTheSame() {
        // given
        var handledImagePickerController: UIImagePickerController?
        var handledMediaInfo: [UIImagePickerController.InfoKey: Any]?

        let imagePickerController = UIImagePickerController()

        let expectedMediaInfo: [UIImagePickerController.InfoKey: Any] = [
            .cropRect: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        ]

        imagePickerController.didFinishPickingMedia { controller, mediaInfo in
            handledImagePickerController = controller
            handledMediaInfo = mediaInfo
        }

        // when
        imagePickerController
            .delegate?
            .imagePickerController?(
                imagePickerController,
                didFinishPickingMediaWithInfo: expectedMediaInfo
            )

        // than
        XCTAssert(handledImagePickerController === imagePickerController)
        XCTAssertEqual(handledMediaInfo?[.cropRect] as? CGRect, expectedMediaInfo[.cropRect] as? CGRect)
    }

    func test_didCancelSelfHandler_whenDelegateTriggered_thanHandledObjectIsTheSame() {
        // given
        var handledImagePickerController: UIImagePickerController?

        let imagePickerController = UIImagePickerController()

        imagePickerController.didCancel { controller in
            handledImagePickerController = controller
        }

        // when
        imagePickerController.delegate?.imagePickerControllerDidCancel?(imagePickerController)

        // than
        XCTAssert(handledImagePickerController === imagePickerController)
    }

    func test_whenMultipleDelegateEvents_thatAllActionsHandled() {
        // given
        var didFinishPickingMediaCalled = false
        var didCancelCalled = false

        let imagePickerController = UIImagePickerController()

        imagePickerController
            .didFinishPickingMedia { _ in
                didFinishPickingMediaCalled = true
            }.didCancel {
                didCancelCalled = true
            }

        // when
        imagePickerController
            .delegate?
            .imagePickerController?(imagePickerController, didFinishPickingMediaWithInfo: [:])

        imagePickerController
            .delegate?
            .imagePickerControllerDidCancel?(imagePickerController)

        // then
        XCTAssertTrue(didFinishPickingMediaCalled)
        XCTAssertTrue(didCancelCalled)
    }
}

#endif
