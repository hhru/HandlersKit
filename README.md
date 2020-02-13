# HandlersKit
[![Build Status](https://travis-ci.org/hhru/HandlersKit.svg?branch=master)](https://travis-ci.org/hhru/HandlersKit)
[![Codecov](https://codecov.io/gh/hhru/HandlersKit/branch/master/graph/badge.svg)](https://codecov.io/gh/hhru/HandlersKit)
[![Cocoapods](https://img.shields.io/cocoapods/v/HandlersKit.svg?style=flat)](http://cocoapods.org/pods/HandlersKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![Xcode](https://img.shields.io/badge/Xcode-11-blue.svg)](https://developer.apple.com/xcode)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![License](https://img.shields.io/github/license/hhru/HandlersKit.svg)](https://opensource.org/licenses/MIT)

HandlersKit is a light-weight iOS Framework that allows you to use modern closure syntax instead of the target-action and delegate patterns. This framework covers the most popular UIKit classes.

## Overview
Closure syntax instead of [UIControl's](https://developer.apple.com/documentation/uikit/uicontrol) target-action mechanism.
```swift
control.on(.valueChanged) {
    print("UIControl's value changed")
}
```
---
Convenient methods for the most common cases.
```swift
button.onTap {
    print("UIButton touch up inside")
}
```
```swift
slider.onChange { newValue in
   print("UISlider changed value")
}
```
---
Access to the same object inside the closure without typecasting or optional unwrapping.
```swift
let button = MyActivityIndicatorButton()
button.onTap { (sender: MyActivityIndicatorButton) in
    sender.showActivityIndicator()
}
```
---
Every method allows [chaining](https://en.wikipedia.org/wiki/Method_chaining).
```swift
textField.shouldChangeString { fromString, toString in
    print("\(fromString) -> \(toString)")
    return true
}.shouldBeginEditing {
    true
}.didEndEditing {
    print("UITextField did end editing")
}
```

## Benefits
- HandlersKit extends [UIControl](https://developer.apple.com/documentation/uikit/uicontrol), [UIBarButtonItem](https://developer.apple.com/documentation/uikit/uibarbuttonitem), [UIGestureRecognizer](https://developer.apple.com/documentation/uikit/uigesturerecognizer), [UITextField](https://developer.apple.com/documentation/uikit/uitextfield) and [UITextView](https://developer.apple.com/documentation/uikit/uitextview).
- Closures stored as associated objects. No singleton or Notification Center used. It means that all objects captured by this closure will be released when that UIKit object released.

## Installation
### CocoaPods
To install HandlersKit using [CocoaPods](http://cocoapods.org) add the following line to your `Podfile`:
```ruby
pod 'HandlersKit'
```
Then run in Terminal:
```sh
$ pod install
```

### Carthage
To integrate HandlersKit into your project using [Carthage](https://github.com/Carthage/Carthage), specify it in your Cartfile:
```shell
github "hhru/HandlersKit"
```

### Swift Package Manager
To integrate HandlersKit into your project using [Swift Package Manager](https://swift.org/package-manager/), you have two different ways:
1. In Xcode, go to `File > Swift Packages > Add Package Dependency...` and enter the following URL:
```
https://github.com/hhru/HandlersKit
```
2. Or add the following as a dependency to your `Package.swift`:
```swift
.package(url: "https://github.com/hhru/HandlersKit.git", from: "1.0.0")
```

### Manual
- Go to [releases page](https://github.com/hhru/HandlersKit/releases).
- Download the latest release `Source code`.
- Drag and drop all .swift files from `HandlersKit-x.y.z/Sources` folder into your Xcode project. Check the option *Copy items if needed*.

## License
HandlersKit is released under the MIT License. (see [LICENSE](https://github.com/hhru/HandlersKit/blob/master/LICENSE)).
