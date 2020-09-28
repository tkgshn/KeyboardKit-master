//
//  DemoAutocompleteSuggestionProvider.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/**
 This action handler inherits `StandardKeyboardActionHandler`
 and adds demo-specific base functionality to it.
 
 The class is shared between all keyboards. Each demo action
 handler inherit this class and adds functionality on top of
 the base functionality.
 */
class DemoKeyboardActionHandlerBase: StandardKeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    init(inputViewController: KeyboardInputViewController) {
        super.init(
            inputViewController: inputViewController,
            hapticConfiguration: .standard
        )
    }
    
    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.handle(gesture, on: action, sender: sender)
    }
    
    /**
     `NOTE` Changing to alphabetic lower case should be done
     in `StandardKeyboardActionHandler`, not here.
     */
    func handleSpace(for sender: Any?) -> GestureAction {
        let baseAction = super.tapAction(for: .space, sender: sender)
        return { [weak self] in
            baseAction?()
            let type = self?.inputViewController?.context.keyboardType
            if type?.isAlphabetic == true { return }
            self?.inputViewController?.changeKeyboardType(to: .alphabetic(.lowercased))
        }
    }
    
    override func longPressAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] in self?.saveImage(UIImage(named: imageName)!) }
        default: return super.longPressAction(for: action, sender: sender)
        }
    }
    
    override func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] in self?.copyImage(UIImage(named: imageName)!) }
        case .space: return handleSpace(for: sender)
        default: return super.tapAction(for: action, sender: sender)
        }
    }
    
    
    // MARK: - Functions
    
    /**
     Override this function to implement a way to alert text
     messages in the keyboard extension. You can't use logic
     that you use in real apps, e.g. `UIAlertController`.
     */
    func alert(_ message: String) {
        assertionFailure("You must override alert")
    }
    
    func copyImage(_ image: UIImage) {
        guard let input = inputViewController else { return }
//        ユーザーがキーボードの許可をしていない場合、フルアクセスの設定をしてもらうように誘導
        guard input.hasFullAccess else { return alert("画像をコピーするにはアクセス権限を与えてください") }
        guard image.copyToPasteboard() else { return alert("この画像はコピーできませんでした") }
//        画像タップ時に表示
        alert("画像をコピーしました!")
    }
    
//    画像を長押し時に画像を保存する
//    保存するアクセス権限がない場合は権限を求める
    func saveImage(_ image: UIImage) {
        guard let input = inputViewController else { return }
        guard input.hasFullAccess else { return alert("キーボードにアクセス権限を与えてください") }
        let saveCompletion = #selector(handleImage(_:didFinishSavingWithError:contextInfo:))
        image.saveToPhotos(completionTarget: self, completionSelector: saveCompletion)
    }


    // MARK: - Image Functions
//    長押しで画像を保存した際の表示
    @objc func handleImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil { alert("保存完了!") }
        else { alert("エラ-!") }
    }
}
