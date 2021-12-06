//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

public protocol HandlersKit { }

#if canImport(UIKit)
import UIKit

extension UIControl: HandlersKit, ObserverHolder, EventsObserverHolder { }

extension UIBarButtonItem: HandlersKit, ObserverHolder { }

extension UIGestureRecognizer: HandlersKit, ObserverHolder { }

extension UITextView: HandlersKit, ObserverHolder { }

extension UIImagePickerController: HandlersKit, ObserverHolder { }

extension UISearchBar: HandlersKit, ObserverHolder { }
#endif

#if canImport(ContactsUI) && os(iOS)
import ContactsUI

extension CNContactViewController: HandlersKit, ObserverHolder { }
#endif
