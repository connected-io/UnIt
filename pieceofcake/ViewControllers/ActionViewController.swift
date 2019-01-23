//
//  ActionViewController.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-07.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldSwitch: UISwitch!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonSwitch: UISwitch!
    
    @IBOutlet weak var numericTextField: UITextField!
    @IBOutlet weak var numericTextFieldSwitch: UISwitch!
    
    // aa2
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        numericTextField.delegate = self
//        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        buttonSwitch.isOn = !buttonSwitch.isOn
    }
    
//    @objc func textFieldEditingChanged(_ textField: UITextField) {
//        textFieldSwitch.isOn = (textField.text!.count > 0)
//    }
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
        NSLog("ActionViewController: textFieldDidEndEditing")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        NSLog("ActionViewController: textFieldShouldEndEditing")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NSLog("ActionViewController: textFieldDidBeginEditing")
    }
}
