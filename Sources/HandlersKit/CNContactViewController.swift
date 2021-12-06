//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(ContactsUI) && os(iOS)
import ContactsUI

extension HandlersKit where Self: CNContactViewController {

    @discardableResult
    public func didFinish(
        handler: @escaping (CNContact?) -> Void
    ) -> Self {
        updateObserver { $0.didFinish = handler }
    }

    private func updateObserver(_ update: (ContactControllerObserver<Self>) -> Void) -> Self {
        if let contactControllerObserver = observer as? ContactControllerObserver<Self> {
            update(contactControllerObserver)
        } else {
            let contactControllerObserver = ContactControllerObserver(contactController: self)
            update(contactControllerObserver)
            observer = contactControllerObserver
        }

        return self
    }
}

private final class ContactControllerObserver<T: CNContactViewController>:
    NSObject,
    CNContactViewControllerDelegate {

    var didFinish: ((CNContact?) -> Void)?

    init(contactController: T) {
        super.init()
        contactController.delegate = self
    }

    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        didFinish?(contact)
    }
}
#endif
