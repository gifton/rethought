
import Foundation
import UIKit

// size calculations and animaete(to:) funcs for msg center and conversationView
open class ConversationPresenter: NSObject {
    
    private let regularMessageCenterHeight: CGFloat = 115.0
    private var isShowingEntry: Bool = false
    private var isShowingKeyboard: Bool = false
    //conversationPosition is an internal data type for setting up animating views to
    // desired position
    private struct ConversationPosition{
        var msgFrame: CGRect
        var viewFrame: CGRect
        
        init(msgFrame: CGRect, viewFrame: CGRect) {
            self.msgFrame = msgFrame
            self.viewFrame = viewFrame
            
        }
        static var barHeight = Device.size.tabBarHeight
        static var max = Device.size.self
        static var msg = MSGContext.size.self
        static func standard() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (barHeight + msg.regular.rawValue), width: max.width, height: msg.regular.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (barHeight + msg.regular.rawValue)))
        }
        static func link() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (msg.link.rawValue), width: max.width, height: msg.link.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (msg.link.rawValue)))
        }
        static func recording() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (msg.recording.rawValue), width: max.width, height: msg.recording.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (msg.recording.rawValue)))
        }
        static func note() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (msg.note.rawValue), width: max.width, height: msg.note.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (msg.note.rawValue)))
        }
        static func photo() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (msg.photo.rawValue), width: max.width, height: msg.photo.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (msg.photo.rawValue)))
        }
    }
    
    // MARK: Private vars
    private var parent: ConversationView
    private var msgCenter: MSGCenter
    private var view: UIScrollView
    init(_ view: UIScrollView, _ msgCenter: MSGCenter, parent: ConversationView) {
        self.view = view
        self.msgCenter = msgCenter
        self.parent = parent
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupInitialConversation()
    }
    
    var msgDely: MSGConnector?
    private func setupInitialConversation() {
        //insert delegates
        msgCenter.delegate = self
        view.delegate = self
        
        //layout newobjects, frame, color, rounded edges, etc
        msgCenter.frame = CGRect(x: 0, y: parent.frame.height - regularMessageCenterHeight, width: parent.frame.width, height: regularMessageCenterHeight)
        
        //set alphas to 0
        self.msgCenter.alpha = 0.0
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.25) {
            self.msgCenter.alpha = 1.0
            self.view.alpha = 1.0
        }
    }
}

extension ConversationPresenter {
    private func animateTo(position: ConversationPosition) {
        //uiview animate to position
        if msgCenter.textView.isFirstResponder {
            UIView.animate(withDuration: 0.45) {
                self.msgCenter.frame = position.msgFrame
                self.view.frame = position.viewFrame
            }
        } else {
            UIView.animate(withDuration: 0.45) {
                self.msgCenter.frame = position.msgFrame
                self.view.frame = position.viewFrame
            }
        }
        
//        view.roundCorners([.bottomLeft, .bottomRight], radius: 20)
    }
}

extension ConversationPresenter: UIScrollViewDelegate {
    //when scroll view scrolls, if entry or keyboard are showing
    // hide them
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        msgCenter.textView.resignFirstResponder()
        if msgCenter.isShowingEntry {
            print(self.msgCenter.removeEntryView())
            animateTo(position: .standard())
        }
        msgDely?.isDoneEditing()
    }
}

extension ConversationPresenter: MSGCenterDelegate {
    func didTapEntry(ofType type: MSGContext.size, completion: ()) {
        
        // if msgCenter view is equal to entry tapped
        // assume entry is the same, and close the entry and set regular view
        if msgCenter.frame.size.height == type.rawValue {
            // hide entry, dont complete completion
            animateTo(position: .standard())
            msgCenter.setInitialView()
            
            // if entry view is currently showing
            // or no entry is showing at all,
            // animate to correct entry view, run completion
        } else {
            
            // if the keyboard is showing, hide keyboard and go to new view
            if isShowingKeyboard {
                msgCenter.textView.resignFirstResponder()
            }
            
            switch type {
            case .link: animateTo(position: .link())
            case .photo: animateTo(position: .photo())
            case .note: animateTo(position: .note())
            case .recording: animateTo(position: .recording())
            default: animateTo(position: .standard())
            }
            
            isShowingEntry = true
            completion
        }
    }
    
    //after send is confirmed, hide errything
    public func didSendMessage() {
        //move to regular height again
        animateTo(position: .standard())
        msgCenter.textView.resignFirstResponder()
        _ = msgCenter.removeEntryView()
    }
    
    
    private func getEntryFromSize(_ size: MSGContext.size = MSGContext.size.regular) -> EntryType {
        if size == .regular {
            switch msgCenter.frame.height {
            case MSGContext.size.link.rawValue: return .link
            case MSGContext.size.recording.rawValue: return .recording
            case MSGContext.size.photo.rawValue: return .photo
            case MSGContext.size.note.rawValue: return .note
            default: return .none
            }
        }
        
        switch size {
        case MSGContext.size.link: return .link
        case MSGContext.size.recording: return .recording
        case MSGContext.size.photo: return .photo
        case MSGContext.size.note: return .note
        default: return .none
        }
    }
    
    //keyboard funcs
    @objc func keyboardWillShow(notification: Notification) { isShowingKeyboard = true }
    
    @objc func keyboardWillHide(notification: Notification) { isShowingKeyboard = false }
}

