//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

public protocol HandlersKit { }

extension UIControl: HandlersKit, ObserverHolder, EventsObserverHolder { }

extension UIBarButtonItem: HandlersKit, ObserverHolder { }

extension UIGestureRecognizer: HandlersKit, ObserverHolder { }

extension UITextView: HandlersKit, ObserverHolder { }

extension UIImagePickerController: HandlersKit, ObserverHolder { }

extension UISearchBar: HandlersKit, ObserverHolder { }

#endif

#if canImport(ContactsUI)
import ContactsUI

extension CNContactViewController: HandlersKit, ObserverHolder { }
#endif
