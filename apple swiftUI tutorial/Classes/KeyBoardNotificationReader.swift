//
//  KeyBoardNotificationReader.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 18.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import UIKit
import Combine

enum KeyboardTransitionState {
    case unset, willShow, didShow, willHide, didHide
}

struct KeyboardState {
   var state:KeyboardTransitionState = .unset
    var height = 0.0
    var isVisible = false
    var frame:CGRect = CGRect.zero
    var animationDuration = 0.0

    // MARK: Private
    private let frameEnd = UIResponder.keyboardFrameEndUserInfoKey
    private let animEnd = UIResponder.keyboardAnimationDurationUserInfoKey

    init(with note:Notification) {
        switch note.name {
        case UIResponder.keyboardWillShowNotification:
            state = .willShow
            let keyboardEndFrame = note.userInfo?[frameEnd] as! CGRect
            height = Double(keyboardEndFrame.size.height)
            
            let animationDurationValue = note.userInfo?[animEnd] as! NSNumber
            animationDuration = animationDurationValue.doubleValue
        break
        case UIResponder.keyboardDidShowNotification:
            state = .didShow
            isVisible = true
            
            let keyboardEndFrame = note.userInfo?[frameEnd] as! CGRect
            height = Double(keyboardEndFrame.size.height)
        break
        case UIResponder.keyboardWillHideNotification:
            state = .willHide
            let animationDurationValue = note.userInfo?[animEnd] as! NSNumber
            animationDuration = animationDurationValue.doubleValue
        break
        case UIResponder.keyboardDidHideNotification:
            state = .didHide
        break
        default:
            break
        }
    }
}

class KeyboardHandler {
    let onChange:((KeyboardState) -> Void)
    private(set) var currentState:KeyboardState?
    
    private lazy var kbSub:AnyCancellable? = AnyCancellable() {}
    private let keyboardNotifications:[NSNotification.Name] = [
        UIResponder.keyboardWillShowNotification,
        UIResponder.keyboardDidShowNotification,
        UIResponder.keyboardWillHideNotification,
        UIResponder.keyboardDidHideNotification]
    
    // MARK: Initializer

    init(with changeHandler:@escaping ((KeyboardState) -> Void)) {
        onChange = changeHandler
        
        
            let nc = NotificationCenter.default
            kbSub = Publishers.MergeMany(
                keyboardNotifications.map { nc.publisher(for: $0) }
            )
            .sink(receiveValue: { (note) in
                self.currentState = KeyboardState(with: note)
                self.onChange(KeyboardState(with: note))
            })
        
    }
    
    func unsubscribe() {
   
            kbSub?.cancel()
        
    }
    
    //MARK: Private Functions

    @objc func receivedKeyboardNotification(notification: Notification) {
        currentState = KeyboardState(with: notification)
        onChange(KeyboardState(with: notification))
    }
}
