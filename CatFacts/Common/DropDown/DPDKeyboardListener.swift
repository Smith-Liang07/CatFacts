//
//  KeyboardListener.swift
//  DropDown
//
//  Created by Kevin Hirsch on 30/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

import UIKit

internal final class KeyboardListener {
	
	static let sharedInstance = KeyboardListener()
	
	fileprivate(set) var isVisible = false
	fileprivate(set) var keyboardFrame = CGRect.zero
	fileprivate var isListening = false
	
	deinit {
		stopListeningToKeyboard()
	}
	
}

//MARK: - Notifications

extension KeyboardListener {
	
	func startListeningToKeyboard() {
		if isListening {
			return
		}
		
		isListening = true
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(KeyboardListener.keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
			object: nil)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(KeyboardListener.keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
			object: nil)
	}
	
	func stopListeningToKeyboard() {
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc
	fileprivate func keyboardWillShow(_ notification: Notification) {
		isVisible = true
		keyboardFrame = keyboardFrameFromNotification(notification)
	}
	
	@objc
	fileprivate func keyboardWillHide(_ notification: Notification) {
		isVisible = false
		keyboardFrame = keyboardFrameFromNotification(notification)
	}
	
	fileprivate func keyboardFrameFromNotification(_ notification: Notification) -> CGRect {
        return (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
	}
	
}
