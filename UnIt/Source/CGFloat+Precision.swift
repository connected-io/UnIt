public extension CGFloat {
    func roundTo(decimalPlace: Int) -> CGFloat {
        let divisor = CGFloat(10 ^ decimalPlace)
        return (self * divisor).rounded() / divisor
    }
}
