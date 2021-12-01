//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

extension HandlersKit where Self: UISearchBar {

    @discardableResult
    public func shouldBeginEditing(handler: @escaping (Self) -> Bool) -> Self {
        updateObserver { $0.shouldBeginEditing = handler }
    }

    @discardableResult
    public func shouldBeginEditing(handler: @escaping () -> Bool) -> Self {
        shouldBeginEditing { _ in handler() }
    }

    @discardableResult
    public func didBeginEditing(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didBeginEditing = handler }
    }

    @discardableResult
    public func didBeginEditing(handler: @escaping () -> Void) -> Self {
        didBeginEditing { _ in handler() }
    }

    @discardableResult
    public func shouldEndEditing(handler: @escaping (Self) -> Bool) -> Self {
        updateObserver { $0.shouldEndEditing = handler }
    }

    @discardableResult
    public func shouldEndEditing(handler: @escaping () -> Bool) -> Self {
        shouldEndEditing { _ in handler() }
    }

    @discardableResult
    public func didEndEditing(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didEndEditing = handler }
    }

    @discardableResult
    public func didEndEditing(handler: @escaping () -> Void) -> Self {
        didEndEditing { _ in handler() }
    }

    @discardableResult
    public func textDidChange(handler: @escaping (Self, String) -> Void) -> Self {
        updateObserver { $0.textDidChange = handler }
    }

    @discardableResult
    public func textDidChange(handler: @escaping (String) -> Void) -> Self {
        textDidChange { handler($1) }
    }

    @discardableResult
    public func shouldChangeText(handler: @escaping (Self, NSRange, String) -> Bool) -> Self {
        updateObserver { $0.shouldChangeText = handler }
    }

    @discardableResult
    public func shouldChangeText(handler: @escaping (NSRange, String) -> Bool) -> Self {
        shouldChangeText { handler($1, $2) }
    }

    @discardableResult
    public func searchButtonClicked(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.searchButtonClicked = handler }
    }

    @discardableResult
    public func searchButtonClicked(handler: @escaping () -> Void) -> Self {
        searchButtonClicked { _ in handler() }
    }

    @discardableResult
    public func bookmarkButtonClicked(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.bookmarkButtonClicked = handler }
    }

    @discardableResult
    public func bookmarkButtonClicked(handler: @escaping () -> Void) -> Self {
        bookmarkButtonClicked { _ in handler() }
    }

    @discardableResult
    public func cancelButtonClicked(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.cancelButtonClicked = handler }
    }

    @discardableResult
    public func cancelButtonClicked(handler: @escaping () -> Void) -> Self {
        cancelButtonClicked { _ in handler() }
    }

    @discardableResult
    public func resultsListButtonClicked(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.resultsListButtonClicked = handler }
    }

    @discardableResult
    public func resultsListButtonClicked(handler: @escaping () -> Void) -> Self {
        resultsListButtonClicked { _ in handler() }
    }

    @discardableResult
    public func selectedScopeButtonIndexDidChange(handler: @escaping (Self, Int) -> Void) -> Self {
        updateObserver { $0.selectedScopeButtonIndexDidChange = handler }
    }

    @discardableResult
    public func selectedScopeButtonIndexDidChange(handler: @escaping (Int) -> Void) -> Self {
        selectedScopeButtonIndexDidChange { handler($1) }
    }

    private func updateObserver(_ update: (SearchBarObserver<Self>) -> Void) -> Self {
        if let searchBarObserver = observer as? SearchBarObserver<Self> {
            update(searchBarObserver)
        } else {
            let searchBarObserver = SearchBarObserver(searchBar: self)
            update(searchBarObserver)
            observer = searchBarObserver
        }
        return self
    }
}

private final class SearchBarObserver<T: UISearchBar>: NSObject, UISearchBarDelegate {

    var shouldBeginEditing: ((T) -> Bool)?
    var didBeginEditing: ((T) -> Void)?
    var shouldEndEditing: ((T) -> Bool)?
    var didEndEditing: ((T) -> Void)?
    var textDidChange: ((T, _ searchText: String) -> Void)?
    var shouldChangeText: ((T, _ range: NSRange, _ replacementText: String) -> Bool)?
    var searchButtonClicked: ((T) -> Void)?
    var bookmarkButtonClicked: ((T) -> Void)?
    var cancelButtonClicked: ((T) -> Void)?
    var resultsListButtonClicked: ((T) -> Void)?
    var selectedScopeButtonIndexDidChange: ((T, _ selectedScope: Int) -> Void)?

    init(searchBar: T) {
        super.init()

        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        guard let searchBar = searchBar as? T, let shouldBeginEditing = shouldBeginEditing else {
            return true
        }

        return shouldBeginEditing(searchBar)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let searchBar = searchBar as? T else {
            return
        }

        didBeginEditing?(searchBar)
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        guard let searchBar = searchBar as? T, let shouldEndEditing = shouldEndEditing else {
            return true
        }

        return shouldEndEditing(searchBar)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchBar = searchBar as? T else {
            return
        }

        didEndEditing?(searchBar)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBar = searchBar as? T else {
            return
        }

        textDidChange?(searchBar, searchText)
    }

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let searchBar = searchBar as? T, let shouldChangeText = shouldChangeText else {
            return true
        }

        return shouldChangeText(searchBar, range, text)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBar = searchBar as? T else {
            return
        }

        searchButtonClicked?(searchBar)
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBar = searchBar as? T else {
            return
        }

        bookmarkButtonClicked?(searchBar)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBar = searchBar as? T else {
            return
        }

        cancelButtonClicked?(searchBar)
    }

    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBar = searchBar as? T else {
            return
        }

        resultsListButtonClicked?(searchBar)
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let searchBar = searchBar as? T else {
            return
        }

        selectedScopeButtonIndexDidChange?(searchBar, selectedScope)
    }
}

#endif
