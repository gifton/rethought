//
//  EmojiDisplay.swift
//  rethought
//
//  Created by Dev on 1/23/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//emoji display allows users to add an emoji to
// to thought
//paired with ThoughtIcon class
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
        self.backgroundColor = .cardLabelBackgroundDark
        self.layer.cornerRadius = 6
        self.textAlignment = .center
        self.font = .reBody(ofSize: 30)
        self.isEditable = true
    }
}

extension EmojiDisplay: UITextViewDelegate {
    //overrides the previous char
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 1 {
            textView.text = "\(textView.text!.last!)"
        }
        self.isCompleted = true
    }
    //set completion to yes
    func textViewDidEndEditing(_ textView: UITextView) {
        self.isCompleted = true
    }
}

extension EmojiDisplay: EmojiDisplayIsEditable {
    //set new emoji
    var emoji: ThoughtIcon {
        get {
            return ThoughtIcon(self.text)
        }
        set {
            self.text = newValue.icon
        }
    }
}


//emoji delegate
protocol EmojiDisplayIsEditable {
    var emoji: ThoughtIcon { get set }
}

