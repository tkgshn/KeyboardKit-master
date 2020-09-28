//
//  ToastAlertTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-02-25.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import KeyboardKit

class ToastAlertTests: QuickSpec {
    
    override func spec() {
        
        describe("appearance") {
            
            it("uses standard appearance by default") {
                let alerter = ToastAlert()
                expect(alerter.appearance.backgroundColor).to(equal(.white))
                expect(alerter.appearance.cornerRadius).to(equal(10))
                expect(alerter.appearance.font).to(equal(.systemFont(ofSize: 10)))
                expect(alerter.appearance.horizontalPadding).to(equal(20))
                expect(alerter.appearance.textColor).to(equal(.black))
                expect(alerter.appearance.verticalOffset).to(equal(0))
                expect(alerter.appearance.verticalPadding).to(equal(10))
            }
        }
    }
}
