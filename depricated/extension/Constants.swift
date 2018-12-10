//
//  Constants.swift
//  Rember
//
//  Created by Dev on 10/21/18.
//  Copyright © 2018 pairso. All rights reserved.
//

import Foundation
import UIKit

//font size
enum fontSize: CGFloat {
    case small = 12.0
    case medium = 14.0
    case large = 16.0
    case xLarge = 18.0
    case xXLarge = 20.0
    case xXXLarge = 26.0
    case xXXXLarge = 32.0
}

struct ViewSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ViewSize.SCREEN_WIDTH, ViewSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ViewSize.SCREEN_WIDTH, ViewSize.SCREEN_HEIGHT)
    static let SCALE = UIScreen.main.scale
    static let FRAME = UIScreen.main.bounds
    
    static let reccomendedView = CGSize(width: 350, height: 156)
    static let reccomendedCell = CGSize(width: 325, height: 80)
    static let largeButton = CGSize(width: 350, height: 56)
    static let thoughtCellSmall = CGSize(width: 82, height: 76)
    static let thoughtIconSmall = CGSize(width: 56, height: 56)
    static let minimumEntryPreviewSize = CGSize(width: 350, height: 103)
}

struct App {
    static let domain = Bundle.main.bundleIdentifier!
    
    static func error(domain: ErrorDomain = .generic, code: Int? = nil, localizedDescription: String = "") -> NSError {
        return NSError(domain: App.domain + "." + domain.rawValue,
                       code: code ?? 0,
                       userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}

enum ErrorDomain: String {
    case generic = "GenericError"
    case parsing = "ParsingError"
}

extension UIColor {
    static let backgroundWhite = UIColor(hex: "EDEDED")
    static let cellBackgroundWhite = UIColor(hex: "F0F0F0")
    static let titleLightGray = UIColor(hex: 868686)
    static let titleDarkGray = UIColor(hex: 444444)
    static let mainRed = UIColor(hex: "E91E63")
    static let mainBlue = UIColor(hex: "55AFF8")
    static let accentGray = UIColor(hex: "DDDEE1")
    static let brightGreen = UIColor(hex: "51DF9F")
    static let blueSmoke = UIColor(hex: "DDDDE6")
    static let backgroundAccentGray = UIColor(hex: "DEDEDE")
    
    static let darkText = UIColor(hex: "333333")
}

public func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0...length-1).map{ _ in letters.randomElement()! })
}
