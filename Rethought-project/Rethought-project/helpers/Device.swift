

import Foundation
import UIKit

//all custom global variables
struct Device {
    //static sizes used globally
    struct size {
        static let width  = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let frame  = UIScreen.main.bounds
        
        static let paddedMaxWith = UIScreen.main.bounds.size.width - 10
        
        static let largeTile = CGSize(width: 290, height: 165)
        static let smallTile = CGSize(width: 75, height: 105)
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
    }
    
    struct colors {
        static let offWhite   = UIColor(hex: "F9F9F9")
        static let accentGray = UIColor(hex: "E7E7E8")
        static let darkText   = UIColor(hex: "3D3D46")
        static let lightClay  = UIColor(hex: "F8F8FC")
        static let mainGreen  = UIColor(hex: "51DF9F")
        static let mainBlue   = UIColor(hex: "5066E3")
    }
    
    struct font {
        static func title(ofSize: fontSize) -> UIFont {
            return UIFont.systemFont(ofSize: ofSize.rawValue, weight: .bold)
        }
        static func mediumTitle(ofSize: fontSize) -> UIFont {
            return UIFont.systemFont(ofSize: ofSize.rawValue, weight: .medium)
        }
        static func body(ofSize: fontSize) -> UIFont {
            return UIFont.systemFont(ofSize: ofSize.rawValue, weight: .regular)
        }
        static func lightBody(ofSize: fontSize) -> UIFont {
            return UIFont.systemFont(ofSize: ofSize.rawValue, weight: .light)
        }
        
        static func formalBodyText(ofSize: fontSize) -> UIFont {
            return UIFont.init(name: "Palatino-Roman", size: ofSize.rawValue)!
        }
    }
}
