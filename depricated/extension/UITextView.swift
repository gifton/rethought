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

class EmojiDisplay: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        delegate = self
        styleCell()
    }
    
    convenience init(frame: CGRect, emoji: ThoughtIcon) {
        self.init(frame: frame)
        self.text = emoji.icon
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func styleCell() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.28)
        self.layer.cornerRadius = 6
        self.textAlignment = .center
        self.font = .reBody(ofSize: 77)
        self.isEditable = false
    }
}

extension EmojiDisplay: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

extension EmojiDisplay: EmojiDisplayIsEditable {
    var emoji: ThoughtIcon {
        get {
            return ThoughtIcon(self.text)
        }
        set {
            self.text = newValue.icon
        }
    }
}

protocol EmojiDisplayIsEditable {
    var emoji: ThoughtIcon { get set }
}
