//
//  ReTextField.swift
//  rethought
//
//  Created by Dev on 1/23/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ReTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        self.textColor = .darkBackground
        self.textAlignment = .center
        self.layer.masksToBounds = true
        self.addBorders(edges: [.bottom], color: .black, thickness: 8)
    }
    
    convenience init(frame: CGRect, attPlaceholder: String) {
        self.init(frame: frame)
        self.attPlaceholder = attPlaceholder
    }
    
    public var isCompleted: Bool = false
    public var size: CGFloat = 12
    public var color: UIColor = .black
    public var connector: ConnectToTextView?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReTextField: ReTextFieldDelegate {
    public var attPlaceholder: String {
        get {
            return text ?? ""
        }
        set {
            self.attributedPlaceholder = self.returnAttributedText(color: color, size: size, font: .body, string: newValue)
        }
    }
}

extension ReTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.attPlaceholder = ""
        self.text = ""
        self.isCompleted = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isCompleted = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.connector?.textFieldDidFinishEditing(string: self.text ?? "nil")
        self.resignFirstResponder()
        return false
    }
    
}

protocol ReTextFieldDelegate {
    var attPlaceholder: String { get set }
}
