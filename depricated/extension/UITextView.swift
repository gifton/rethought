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
    }
    
    
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
            text = newValue
        }
    }
}

extension ReTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

protocol ReTextViewDelegate {
    var placeholder: String { get set }
}
