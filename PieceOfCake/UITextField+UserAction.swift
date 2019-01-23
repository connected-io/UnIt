//
//  UITextField+UserAction.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-08.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    /**
     Simulates **typing** in a **UITextField** one character at a time. Supposed to emulate typing on the iOS
     keyboard.
     - parameters:
        - text: the string that is being typed into the textfield.
     */
    public func type(with text: String) {
        self.becomeFirstResponder()
        let characters = text.map { String($0) }
        for currentCharacter in characters {
            let range = NSRange.init(location: self.text?.count ?? 0, length: 0)
            let delegate = self.delegate
            let shouldAcceptCharacter = delegate?.textField?(self, shouldChangeCharactersIn: range, replacementString: currentCharacter) ?? true
            if (shouldAcceptCharacter) {
                self.insertText(currentCharacter)
                self.sendActions(for: .editingChanged)
            }
        }
        
        self.resignFirstResponder()
    }
    
    /**
     Simulates **pasting** in a **UITextField**. Supposed to simulate to copy and pasting on iOS.
     - parameters:
        - text: the string that is being pasted into the textfield.
     */
    public func paste(with text: String) {
        self.becomeFirstResponder()
        let delegate = self.delegate
        let range = NSRange.init(location: self.text?.count ?? 0, length: 0)
        let shouldAcceptCharacter = delegate?.textField?(self, shouldChangeCharactersIn: range, replacementString: text) ?? true
        if (shouldAcceptCharacter) {
            self.insertText(text)
            self.sendActions(for: .editingChanged)
        }
        
        self.resignFirstResponder()
    }
}
