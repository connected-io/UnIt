import UIKit

class ActionViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldSwitch: UISwitch!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonSwitch: UISwitch!
    
    @IBOutlet weak var numericTextField: UITextField!
    @IBOutlet weak var numericTextFieldSwitch: UISwitch!
    
    @IBOutlet weak var firstHiddenButton: UIButton!
    @IBOutlet weak var secondHiddenButton: UIButton!
    @IBOutlet weak var hiddenViewThatContainsButton: UIView!
    @IBOutlet weak var buttonInHiddenView: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        numericTextField.delegate = self
        firstHiddenButton.isHidden = true
        secondHiddenButton.alpha = 0
        hiddenViewThatContainsButton.isHidden = true
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        buttonSwitch.isOn = !buttonSwitch.isOn
    }
}

extension ActionViewController : UITextFieldDelegate {
    func textField(_ localTextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = localTextField.text,
            let textRange = Range(range, in: text) {
            let newText = text.replacingCharacters(in: textRange, with: string)
            if textField == localTextField {
                textFieldSwitch.isOn = (newText.count > 0)
            } else {
                let numericString = string
                    .components(separatedBy:CharacterSet.decimalDigits.inverted)
                    .joined(separator: "")
                return numericString == string
            }
        }
        return true

    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("ActionViewController: textFieldDidEndEditing")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("ActionViewController: textFieldShouldEndEditing")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("ActionViewController: textFieldDidBeginEditing")
    }
}
