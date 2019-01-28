import Foundation

public extension UITextField {
    /**
     Simulates **typing** in a **UITextField** one character at a time. Supposed to emulate typing on the iOS
     keyboard.
     - parameters:
        - text: the string that is being typed into the textfield.
     */
    func type(with text: String) {
        becomeFirstResponder()
        let characters = text.map { String($0) }
        for currentCharacter in characters {
            let range = NSRange(location: self.text?.count ?? 0, length: 0)
            let shouldAcceptCharacter = delegate?.textField?(self, shouldChangeCharactersIn: range, replacementString: currentCharacter) ?? true
            if (shouldAcceptCharacter) {
                insertText(currentCharacter)
                sendActions(for: .editingChanged)
            }
        }
        
        resignFirstResponder()
    }
    
    /**
     Simulates **pasting** in a **UITextField**. Supposed to simulate to copy and pasting on iOS.
     - parameters:
        - text: the string that is being pasted into the textfield.
     */
    func paste(with text: String) {
        becomeFirstResponder()
        let range = NSRange(location: self.text?.count ?? 0, length: 0)
        let shouldAcceptCharacter = delegate?.textField?(self, shouldChangeCharactersIn: range, replacementString: text) ?? true
        if (shouldAcceptCharacter) {
            insertText(text)
            sendActions(for: .editingChanged)
        }
        
        resignFirstResponder()
    }
}
