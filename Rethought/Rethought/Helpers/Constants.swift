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
    static let darkBackground           = UIColor(hex: "161616")
    static let mainBlue                 = UIColor(hex: "5066E3")
    static let cardBackground           = UIColor(hex: "414468")
    static let cardLabelBackgroundLight = UIColor.white.withAlphaComponent(0.15)
    static let cardLabelBackgroundDark  = UIColor.black.withAlphaComponent(0.15)
    static let cancelColor              = UIColor(hex: "F2BE54")
    static let highlightGreen           = UIColor(hex: "51DF9F")
}

public func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0...length-1).map{ _ in letters.randomElement()! })
}
