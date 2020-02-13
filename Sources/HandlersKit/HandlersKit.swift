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

#endif
