import Foundation
import UIKit

//emoji display allows users to add an emoji to
// to thought
//paired with ThoughtIcon class
class IconView: UITextView {
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
    var isCompleted: Bool = false
    
    public func styleCell() {
        backgroundColor = UIColor.white.withAlphaComponent(0.25)
        layer.cornerRadius = 19
        textAlignment = .center
        font = Device.font.body(ofSize: .emojiLG)
        isEditable = true
        isScrollEnabled = false
    }
}

extension IconView: UITextViewDelegate {
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

extension IconView: EmojiDisplayIsEditable {
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
