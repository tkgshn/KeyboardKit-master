//
//  KeyboardAction+SystemTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class KeyboardAction_SystemTests: QuickSpec {
    
    override func spec() {
        
        let actions = KeyboardAction.testActions
        
        describe("system font") {
            
            it("is defined for all actions") {
                actions.forEach {
                    expect($0.systemFont).to(equal(UIFont.preferredFont(forTextStyle: $0.systemTextStyle)))
                }
            }
        }
        
        describe("system keyboard button text") {
            
            func result(for action: KeyboardAction) -> String? {
                action.systemKeyboardButtonText
            }
            
            it("is defined for some actions") {
                expect(result(for: .character("A"))).to(equal("A"))
                expect(result(for: .emoji("🛸"))).to(equal("🛸"))
                expect(result(for: .emojiCategory(.animals))).to(equal("🐻"))
                expect(result(for: .keyboardType(.numeric))).to(equal("123"))
                expect(result(for: .keyboardType(.symbolic))).to(equal("#+="))
                
                expect(result(for: .none)).to(beNil())
                expect(result(for: .backspace)).to(beNil())
                expect(result(for: .command)).to(beNil())
                expect(result(for: .control)).to(beNil())
                expect(result(for: .custom(name: ""))).to(beNil())
                expect(result(for: .dictation)).to(beNil())
                expect(result(for: .dismissKeyboard)).to(beNil())
                expect(result(for: .escape)).to(beNil())
                expect(result(for: .function)).to(beNil())
                expect(result(for: .moveCursorBackward)).to(beNil())
                expect(result(for: .moveCursorForward)).to(beNil())
                expect(result(for: .newLine)).to(beNil())
                expect(result(for: .nextKeyboard)).to(beNil())
                expect(result(for: .option)).to(beNil())
                expect(result(for: .shift(currentState: .lowercased))).to(beNil())
                expect(result(for: .shift(currentState: .uppercased))).to(beNil())
                expect(result(for: .shift(currentState: .capsLocked))).to(beNil())
                expect(result(for: .space)).to(beNil())
                expect(result(for: .tab)).to(beNil())
            }
        }
        
        describe("system text style") {
            
            func getActions(_ actions: KeyboardAction...) -> [KeyboardAction] { actions }
            
            it("is custom for some actions, but defined for all") {
                let expectedTitle1 = getActions(.emoji(""), .emojiCategory(.smileys))
                var expectedBody = actions.filter { $0.isSystemAction && $0.systemKeyboardButtonText != nil }
                expectedBody.append(.character("abc"))
                
                actions.forEach {
                    if expectedTitle1.contains($0) {
                        expect($0.systemTextStyle).to(equal(.title1))
                    } else if expectedBody.contains($0) {
                        expect($0.systemTextStyle).to(equal(.body))
                    } else {
                        expect($0.systemTextStyle).to(equal(.title2))
                    }
                }
            }
        }
    }
}
