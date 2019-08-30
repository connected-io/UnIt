import UIKit

class AccessibilityViewController: UIViewController {
    @IBOutlet weak var encapsulatingView: UIView!
    @IBOutlet weak var clickMeButton: UIButton!
    @IBOutlet weak var encapsulatedLabel: UILabel!
    @IBOutlet weak var horizontalSlider: UISlider!
    @IBOutlet weak var dollarSignLabel: UILabel!
    @IBOutlet weak var dollarTextField: UITextField!
    
    public var buttonTaps = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        encapsulatingView.accessibilityIdentifier = "encapsulatingView"
        
        encapsulatingView.isAccessibilityElement = true
        encapsulatingView.accessibilityLabel = encapsulatedLabel.text
        
        let action = UIAccessibilityCustomAction(name: "Click the Button", target: self, selector: #selector(buttonClicked))
        encapsulatingView.accessibilityCustomActions = [action]
        
        
        dollarSignLabel.isAccessibilityElement = false
        dollarTextField.isAccessibilityElement = true
        dollarTextField.accessibilityLabel = "Price"
        dollarTextField.accessibilityHint = "Price in Canadian Dollars"
        dollarTextField.accessibilityValue = description(for: dollarTextField.text ?? "")
        
    }
    
    @IBAction func buttonClicked() {
        buttonTaps += 1
    }
    
    private func description(for price: String) -> String {
        guard let dollars = price.split(separator: ".").first,
            let cents = price.split(separator: ".").last
            else { return "Unknown" }
        return "\(dollars) dollars and \(cents) cents"
    }
    
    
}
