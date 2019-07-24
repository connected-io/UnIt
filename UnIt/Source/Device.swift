/**
 Screensizes and scale factor from: https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
 */

public enum Device {
    case iPhoneSE
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6SPlus
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXR
    case iPhoneXS
    case iPhoneXSMax
    
    var dimensions: (screensize: CGSize, scaleFactor: CGFloat) {
        switch self {
        case .iPhoneSE:
            return (CGSize(width: 320, height: 568), 2.0)
        case .iPhone6, .iPhone6S, .iPhone7, .iPhone8:
            return (CGSize(width: 375, height: 667), 2.0)
        case .iPhone6Plus, .iPhone6SPlus:
            return (CGSize(width: 375, height: 667), 3.0)
        case .iPhone7Plus, .iPhone8Plus:
            return (CGSize(width: 414, height: 736), 3.0)
        case .iPhoneX, .iPhoneXS:
            return (CGSize(width: 375, height: 812), 3.0)
        case .iPhoneXR:
            return (CGSize(width: 414, height: 896), 2.0)
        case .iPhoneXSMax:
            return (CGSize(width: 414, height: 896), 3.0)
        }
    }
}
