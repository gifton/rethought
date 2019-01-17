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
            self.attributedText = self.addAttributedText(color: color, size: size, font: .body, string: newValue)
        }
    }
}

extension ReTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.attributedText = self.addAttributedText(color: color, size: size, font: .body, string: "")
        self.isCompleted = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.isCompleted = true
    }
}

protocol ReTextViewDelegate {
    var placeholder: String { get set }
}



class EmojiDisplay: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        delegate = self
        self.isScrollEnabled = false
        styleCell()
    }
    
    convenience init(frame: CGRect, emoji: ThoughtIcon) {
        self.init(frame: frame)
        self.text = emoji.icon
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var isCompleted: Bool = false
    public func styleCell() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 6
        self.textAlignment = .center
        self.font = .reBody(ofSize: 45)
        self.isEditable = true
    }
}

extension EmojiDisplay: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 1 {
            textView.text = "\(textView.text!.last!)"
        }
        self.isCompleted = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.isCompleted = true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return changedText.count <= 2
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
