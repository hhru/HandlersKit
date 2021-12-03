//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

extension HandlersKit where Self: UIImagePickerController {

    @discardableResult
    public func didFinishPickingMedia(
        handler: @escaping (Self, [UIImagePickerController.InfoKey: Any]) -> Void
    ) -> Self {
        updateObserver { $0.didFinishPickingMedia = handler }
    }

    @discardableResult
    public func didFinishPickingMedia(handler: @escaping ([UIImagePickerController.InfoKey: Any]) -> Void) -> Self {
        didFinishPickingMedia { handler($1) }
    }

    @discardableResult
    public func didCancel(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didCancel = handler }
    }

    @discardableResult
    public func didCancel(handler: @escaping () -> Void) -> Self {
        didCancel { _ in handler() }
    }

    private func updateObserver(_ update: (ImagePickerControllerObserver<Self>) -> Void) -> Self {
        if let imagePickerControllerObserver = observer as? ImagePickerControllerObserver<Self> {
            update(imagePickerControllerObserver)
        } else {
            let imagePickerControllerObserver = ImagePickerControllerObserver(imagePickerController: self)
            update(imagePickerControllerObserver)
            observer = imagePickerControllerObserver
        }

        return self
    }
}

private final class ImagePickerControllerObserver<T: UIImagePickerController>:
    NSObject,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    var didFinishPickingMedia: ((T, [UIImagePickerController.InfoKey: Any]) -> Void)?
    var didCancel: ((T) -> Void)?

    init(imagePickerController: T) {
        super.init()
        imagePickerController.delegate = self
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        guard let imagePickerController = picker as? T, let didFinishPickingMedia = didFinishPickingMedia else {
            return
        }

        didFinishPickingMedia(imagePickerController, info)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        guard let imagePickerController = picker as? T, let didCancel = didCancel else {
            return
        }

        didCancel(imagePickerController)
    }
}
#endif
