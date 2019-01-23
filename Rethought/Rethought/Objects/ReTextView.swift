//
//  UITextView.swift
//  rethought
//
//  Created by Dev on 1/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ReTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
         delegate = self
    }
    
    convenience init(frame: CGRect, placeholder: String) {
        self.init(frame: frame, textContainer: nil)
        self.placeholder = placeholder
        self.textColor = .lightGray
    }
    
    public var isCompleted: Bool = false
    public var size: CGFloat = 12
    public var color: UIColor = .black
    public var connector: ThoughtCardDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReTextView: ReTextViewDelegate {
    public var placeholder: String {
        get {
            return text
        }
        set {
            self.attributedText = self.returnAttributedText(color: color, size: size, font: .body, string: newValue)
        }
    }
}

extension ReTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        connector!.updateState(state: .cardIsEditing)
        
        textView.attributedText = self.returnAttributedText(color: color, size: size, font: .body, string: "")
        self.isCompleted = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.isCompleted = true
    }
}

protocol ReTextViewDelegate {
    var placeholder: String { get set }
}
