public extension CGFloat {
    func roundTo(decimalPlace: Int) -> CGFloat {
        let divisor = CGFloat(truncating: (NSDecimalNumber(decimal: pow(10, decimalPlace))))
        return (self * divisor)
            .rounded(.toNearestOrAwayFromZero)
            / divisor
    }
}
