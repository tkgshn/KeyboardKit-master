//
//  KeyboardActionTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

extension KeyboardAction {
    
    static var testActions: [KeyboardAction] {
        [
            .none,
            .dismissKeyboard,
            .done,
            .character(""),
            .command,
            .control,
            .custom(name: ""),
            .dictation,
            .escape,
            .emoji(""),
            .emojiCategory(.smileys),
            .function,
            .image(description: "", keyboardImageName: "", imageName: ""),
            
            .keyboardType(.alphabetic(.lowercased)),
            .keyboardType(.alphabetic(.uppercased)),
            .keyboardType(.alphabetic(.capsLocked)),
            .keyboardType(.numeric),
            .keyboardType(.symbolic),
            .keyboardType(.email),
            .keyboardType(.emojis),
            .keyboardType(.images),
            .keyboardType(.custom("")),
            
            .moveCursorBackward,
            .moveCursorForward,
            .newLine,
            .nextKeyboard,
            .option,
            .search,
            .shift(currentState: .lowercased),
            .shift(currentState: .uppercased),
            .shift(currentState: .capsLocked),
            .space,
            .systemImage(description: "", keyboardImageName: "", imageName: ""),
            .tab
        ]
    }
}

class KeyboardActionTests: QuickSpec {
    
    override func spec() {
        
        let actions = KeyboardAction.testActions
        
        var expected: [KeyboardAction]! {
            didSet {
                unexpected = actions
                expected.forEach { action in
                    unexpected.removeAll { $0 == action }
                }
            }
        }
        
        var unexpected: [KeyboardAction]!
        
        beforeEach {
            expected = []
            unexpected = []
        }
        
        describe("is input action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isInputAction
            }
            
            it("is true for some actions") {
                expected = [
                    .character(""),
                    .emoji(""),
                    .image(description: "", keyboardImageName: "", imageName: ""),
                    .space,
                    .systemImage(description: "", keyboardImageName: "", imageName: "")
                ]
                expected.forEach { expect(result(for: $0)).to(beTrue()) }
                unexpected.forEach { expect(result(for: $0)).to(beFalse()) }
            }
        }
        
        describe("is system action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isSystemAction
            }
            
            it("is true for some actions") {
                expected = [
                    .backspace,
                    .command,
                    .control,
                    .dictation,
                    .dismissKeyboard,
                    .emojiCategory(.smileys),
                    .escape,
                    .function,
                    .keyboardType(.alphabetic(.lowercased)),
                    .keyboardType(.alphabetic(.uppercased)),
                    .keyboardType(.alphabetic(.capsLocked)),
                    .keyboardType(.numeric),
                    .keyboardType(.symbolic),
                    .keyboardType(.email),
                    .keyboardType(.emojis),
                    .keyboardType(.images),
                    .keyboardType(.custom("")),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
                    .nextKeyboard,
                    .option,
                    .shift(currentState: .lowercased),
                    .shift(currentState: .uppercased),
                    .shift(currentState: .capsLocked),
                    .tab
                ]
                expected.forEach { expect(result(for: $0)).to(beTrue()) }
                unexpected.forEach { expect(result(for: $0)).to(beFalse()) }
            }
        }
    }
}
