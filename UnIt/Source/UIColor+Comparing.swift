import UIKit

public extension UIColor {
    func isNearTo(color: UIColor, margin: CGFloat = 0.5) -> Bool {
        var (selfHue, selfSaturation, selfBrightness, selfAlpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (otherHue, otherSaturation, otherBrightness, otherAlpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        
        getHue(&selfHue, saturation: &selfSaturation, brightness: &selfBrightness, alpha: &selfAlpha)
        color.getHue(&otherHue, saturation: &otherSaturation, brightness: &otherBrightness, alpha: &otherAlpha)
        
        let deltaHue = selfHue - otherHue
        let deltaSaturation = selfSaturation - otherSaturation
        let deltaBrightness = selfBrightness - otherBrightness
        let deltaAlpha = selfAlpha - otherAlpha

        let difference = (deltaHue * deltaHue + deltaSaturation * deltaSaturation + deltaBrightness * deltaBrightness + deltaAlpha * deltaAlpha).squareRoot()
        
        return difference < margin
    }
}
