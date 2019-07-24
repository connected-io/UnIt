import Foundation

public extension CGSize {
    func isEqualTo(otherSize: CGSize, precision: Int = 2) -> Bool {
        let isEqualWidth = self.width.roundTo(decimalPlace: precision) == otherSize.width.roundTo(decimalPlace: precision)
        let isEqualHeight = self.height.roundTo(decimalPlace: precision) == otherSize.height.roundTo(decimalPlace: precision)
        return isEqualWidth && isEqualHeight
    }
}
