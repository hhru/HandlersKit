//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit
import XCTest
@testable import HandlersKit

final class UIControlTests: XCTestCase {

    func test_onSelfHandler_whenSentMultipleActions_thatAllHandledObjectsAreTheSame() {
        // given
        var handledControl1: UIControl?
        var handledControl2: UIControl?
        let control = UIControl()
        control.on(.editingDidBegin) { thatControl in
            handledControl1 = thatControl
        }.on(.editingDidEnd) { thatControl in
            handledControl2 = thatControl
        }

        // when
        control.sendActionsWithSelf(for: .editingDidBegin)
        control.sendActionsWithSelf(for: .editingDidEnd)

        // then
        XCTAssert(handledControl1 === control)
        XCTAssert(handledControl2 === control)
    }

    func test_onVoidHandler_whenSentMultipleActions_thatAllActionsHandled() {
        // given
        var isHandled1 = false
        var isHandled2 = false
        let control = UIControl()
        control.on(.valueChanged) {
            isHandled1 = true
        }.on(.editingChanged) {
            isHandled2 = true
        }

        // when
        control.sendActionsWithSelf(for: .valueChanged)
        control.sendActionsWithSelf(for: .editingChanged)

        // then
        XCTAssertTrue(isHandled1)
        XCTAssertTrue(isHandled2)
    }

    func test_onTapSelfHandler_whenTouchUpInside_thatHandledObjectIsTheSame() {
        // given
        var handledControl: UIButton?
        let control = UIButton()
        control.onTap { thatControl in
            handledControl = thatControl
        }

        // when
        control.sendActionsWithSelf(for: .touchUpInside)

        // then
        XCTAssert(handledControl === control)
    }

    func test_onTapVoidHandler_whenTouchUpInside_thatActionHandled() {
        // given
        var isHandled = false
        let control = UIButton()
        control.onTap {
            isHandled = true
        }

        // when
        control.sendActionsWithSelf(for: .touchUpInside)

        // then
        XCTAssertTrue(isHandled)
    }

    func test_onChangeSwitchSelfHandler_whenValueChanged_thatHandledObjectIsTheSameAndValueCorrect() {
        // given
        var handledControl: UISwitch?
        var handledValue: Bool?
        let control = UISwitch()
        control.onChange { thatControl, value in
            handledControl = thatControl
            handledValue = value
        }

        // when
        control.isOn = true
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssert(handledControl === control)
        XCTAssertEqual(handledValue, control.isOn)
    }

    func test_onChangeSwitchVoidHandler_whenValueChanged_thatValueCorrect() {
        // given
        var handledValue: Bool?
        let control = UISwitch()
        control.onChange { value in
            handledValue = value
        }

        // when
        control.isOn = true
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssertEqual(handledValue, control.isOn)
    }

    func test_onChangeSliderSelfHandler_whenValueChanged_thatHandledObjectIsTheSameAndValueCorrect() {
        // given
        var handledControl: UISlider?
        var handledValue: Float?
        let control = UISlider()
        control.onChange { thatControl, value in
            handledControl = thatControl
            handledValue = value
        }

        // when
        control.value = 0.75
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssert(handledControl === control)
        XCTAssertEqual(handledValue, control.value)
    }

    func test_onChangeSliderVoidHandler_whenValueChanged_thatValueCorrect() {
        // given
        var handledValue: Float?
        let control = UISlider()
        control.onChange { value in
            handledValue = value
        }

        // when
        control.value = 0.75
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssertEqual(handledValue, control.value)
    }

    func test_onChangeSegmentedControlSelfHandler_whenValueChanged_thatHandledObjectIsTheSameAndValueCorrect() {
        // given
        var handledControl: UISegmentedControl?
        var handledValue: Int?
        let control = UISegmentedControl(items: ["1", "2", "3"])
        control.onChange { thatControl, value in
            handledControl = thatControl
            handledValue = value
        }

        // when
        control.selectedSegmentIndex = 1
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssert(handledControl === control)
        XCTAssertEqual(handledValue, control.selectedSegmentIndex)
    }

    func test_onChangeSegmentedControlVoidHandler_whenValueChanged_thatValueCorrect() {
        // given
        var handledValue: Int?
        let control = UISegmentedControl(items: ["1", "2", "3"])
        control.onChange { value in
            handledValue = value
        }

        // when
        control.selectedSegmentIndex = 1
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssertEqual(handledValue, control.selectedSegmentIndex)
    }

    func test_onChangeStepperSelfHandler_whenValueChanged_thatHandledObjectIsTheSameAndValueCorrect() {
        // given
        var handledControl: UIStepper?
        var handledValue: Double?
        let control = UIStepper()
        control.onChange { thatControl, value in
            handledControl = thatControl
            handledValue = value
        }

        // when
        control.value = 10.0
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssert(handledControl === control)
        XCTAssertEqual(handledValue, control.value)
    }

    func test_onChangeStepperVoidHandler_whenValueChanged_thatValueCorrect() {
        // given
        var handledValue: Double?
        let control = UIStepper()
        control.onChange { value in
            handledValue = value
        }

        // when
        control.value = 10.0
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssertEqual(handledValue, control.value)
    }

    func test_onChangePageControlSelfHandler_whenValueChanged_thatHandledObjectIsTheSameAndValueCorrect() {
        // given
        var handledControl: UIPageControl?
        var handledValue: Int?
        let control = UIPageControl()
        control.numberOfPages = 5
        control.onChange { thatControl, value in
            handledControl = thatControl
            handledValue = value
        }

        // when
        control.currentPage = 3
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssert(handledControl === control)
        XCTAssertEqual(handledValue, control.currentPage)
    }

    func test_onChangePageControlVoidHandler_whenValueChanged_thatValueCorrect() {
        // given
        var handledValue: Int?
        let control = UIPageControl()
        control.numberOfPages = 5
        control.onChange { value in
            handledValue = value
        }

        // when
        control.currentPage = 3
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssertEqual(handledValue, control.currentPage)
    }

    func test_onChangeDatePickerSelfHandler_whenValueChanged_thatHandledObjectIsTheSameAndValueCorrect() {
        // given
        var handledControl: UIDatePicker?
        var handledValue: Date?
        let control = UIDatePicker()
        control.onChange { thatControl, value in
            handledControl = thatControl
            handledValue = value
        }

        // when
        control.date = Date(timeIntervalSince1970: 0.0)
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssert(handledControl === control)
        XCTAssertEqual(handledValue, control.date)
    }

    func test_onChangeDatePickerVoidHandler_whenValueChanged_thatValueCorrect() {
        // given
        var handledValue: Date?
        let control = UIDatePicker()
        control.onChange { value in
            handledValue = value
        }

        // when
        control.date = Date(timeIntervalSince1970: 0.0)
        control.sendActionsWithSelf(for: .valueChanged)

        // then
        XCTAssertEqual(handledValue, control.date)
    }
}

extension UIControl {

    func sendActionsWithSelf(for event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target.base as? NSObject)?.perform(NSSelectorFromString(action), with: self)
            }
        }
    }
}

#endif
