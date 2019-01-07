//
//  Constants.swift
//  Rember
//
//  Created by Dev on 10/21/18.
//  Copyright © 2018 pairso. All rights reserved.
//

import Foundation
import UIKit

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
    static let tileBackground = UIColor(hex: "FBF6EB")
}

public func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0...length-1).map{ _ in letters.randomElement()! })
}
