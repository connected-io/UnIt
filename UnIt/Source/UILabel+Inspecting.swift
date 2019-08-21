public extension UILabel {
    /**
     Given the label's text, this function determines how many lines are needed in order to show this label without being truncated.
     - Returns: the number of lines needed to not show truncation with the given text and font.
     */
    func numberOfTheoreticalLines() -> Int {
        // layoutIfNeeded()?
        let myText = text! as NSString
        let labelSize = myText.boundingRect(with: CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        return Int(ceil(CGFloat(labelSize.height) / font.lineHeight))
    }
    
    /**
     Check to see if the text is currently truncated based on its size and font.
     - Returns: A true/false value on whether the label is truncated.
     */
    var isTruncated: Bool {
        return numberOfTheoreticalLines() > numberOfLines && numberOfLines != 0
    }
    
    /**
     Check to see if the text has gone past single-line on a label with no maximum.
     - Returns: A true/false value on whether the label is multilined.
     */
    var isMultilined: Bool {
        return numberOfTheoreticalLines() > 1 && numberOfLines == 0
    }
}
