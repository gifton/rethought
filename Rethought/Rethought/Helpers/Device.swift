
import Foundation
import UIKit

//all custom global variables
struct Device {
    //static sizes used globally
    struct size {
        static let width  = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let frame  = UIScreen.main.bounds
        
        static let paddedMaxWidth = UIScreen.main.bounds.size.width - 20
        
        // card sizes
        static let largeCard = CGSize(width: 300, height: 165)
        static let smallCard = CGSize(width: UIScreen.main.bounds.size.width - 20, height: 80)
        static let newThoughtTile = CGSize(width: UIScreen.main.bounds.size.width, height: 115)
        static let newNoteBoardView: CGFloat = Device.size.width * 0.8
        static let newImageBoardView: CGSize = CGSize(width: 175, height: 219)
        //icon sizes
        static let profileIcon = CGSize(width: 25, height: 29)
        static let entryCardIconHeight: CGFloat = 30.0
        
        //tabbar size
        static let tabBarHeight: CGFloat = 90.0
        static let tabBarIconHeight: CGFloat = 25.0
    }
    
    //retohught fontsizes
    enum fontSize: CGFloat {
        case xSmall    = 10.0
        case small     = 12.0
        case medium    = 14.0
        case large     = 16.0
        case xLarge    = 18.0
        case xXLarge   = 20.0
        case xXXLarge  = 26.0
        case title     = 70
        case xlTitle   = 100
        case emojiSM   = 25
        case emojiLG   = 37.5
    }
    
    struct colors {
        // bg's
        static let offWhite = UIColor(hex: "F2F4F6")
//        static let offWhite = UIColor(white: 0.95, alpha: 1.0)
        static let gradientColors = [UIColor(hex: "14263F"), UIColor(hex: "122450"), UIColor(hex: "381055"), UIColor(hex: "1A2437")]
        //text
        static let lightGray = UIColor(hex: "9F9F9F")
        static let darkGray  = UIColor(hex: "3D3D46")
        //secondary colors
        static let lightClay = UIColor(hex: "8A9699")
        static let green     = UIColor(hex: "579C87")
        static let blue      = UIColor(hex: "5FA4EF")
        static let yellow    = UIColor(hex: "FCCA46")
        static let red       = UIColor(hex: "E54D5F")
        //for entry types
        static let note      = blue
        static let recording = yellow
        static let link      = green
        static let photo     = red
    }
    
    struct font {
        static func title(ofSize: fontSize = fontSize.xXLarge) -> UIFont {
            return UIFont.systemFont(ofSize: ofSize.rawValue, weight: .bold)
        }
        static func mediumTitle(ofSize: fontSize = fontSize.xLarge) -> UIFont {
            return UIFont.systemFont(ofSize: ofSize.rawValue, weight: .medium)
        }
        static func body(ofSize: fontSize = fontSize.medium) -> UIFont {
            return UIFont.systemFont(ofSize: ofSize.rawValue, weight: .regular)
        }
        static func lightBody(ofSize: fontSize = fontSize.small) -> UIFont {
            return UIFont.systemFont(ofSize: ofSize.rawValue, weight: .light)
        }
        
        static func formalBodyText(ofSize: fontSize = fontSize.medium) -> UIFont {
            return UIFont(name: "Lato-Regular", size: ofSize.rawValue)!
        }
    }
    
    static var defaultEmoji = ThoughtIcon("💭")
    
    /// The user enabled Low Power mode
    public var lowPowerMode: Bool {
        if #available(iOS 9.0, *) {
            return ProcessInfo.processInfo.isLowPowerModeEnabled
        } else {
            return false
        }
    }
}
