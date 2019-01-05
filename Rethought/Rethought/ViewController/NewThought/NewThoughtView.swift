//
//  QuickAddView.swift
//  rethought
//
//  Created by Dev on 12/14/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
class NewThoughtView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("this is the frame from our init \(self.frame)")
    }
    
    convenience init(frame: CGRect, delegate: HomeViewControllerDelegate, icon: ThoughtIcon) {
        self.init(frame: frame)
        self.delegate = delegate
        self.currentThoughtIcon = icon
        setupView()
    }
    
    public var delegate: HomeViewControllerDelegate?
    public var currentThoughtIcon: ThoughtIcon?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textView = UITextView(frame: CGRect(x: 50, y: 25, width: ViewSize.SCREEN_WIDTH - 70, height: 30))
    let thoughtButton = UIButton(frame: CGRect(x: 50, y: 25, width: ViewSize.SCREEN_WIDTH - 70, height: 30))
    let recentThought = UIButton(frame: CGRect(x: 10, y: 25, width: 30, height: 30))
    
    func setRecentThought() {
        self.recentThought.setTitle(self.currentThoughtIcon?.icon ?? ThoughtIcon(nil).icon, for: .normal)
    }
}

extension NewThoughtView: UITextViewDelegate {
    func styleView() {
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Light", size: 14),  NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let myAttrString = NSAttributedString(string: "Whats on your mind?", attributes: attribute as [NSAttributedString.Key : Any])
        thoughtButton.backgroundColor = .white
        thoughtButton.layer.cornerRadius = 5
        thoughtButton.setAttributedTitle(myAttrString, for: .normal)
        
        recentThought.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        recentThought.layer.cornerRadius = 4
    }
    fileprivate func setupView() {
        self.setGradientBackground(colorTop: UIColor(hex: "6271FC"), colorBottom: UIColor(hex: "F3A9FF"))
        recentThought.addTarget(self, action: #selector(userDIdStartNewThought(_:)), for: .touchUpInside)
//        thoughtButton.delegate = self
        
        addSubview(thoughtButton)
        addSubview(recentThought)
        
//        recentThought.addTarget(self, action: #selector(userDidTapIcon(_:)), for: .touchUpInside)
        
        styleView()
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//        self.frame.size.height += 300
//        self.frame.origin.y -= 300
//
//        userDidTapTextView()
//    }
    @objc
    func userDIdStartNewThought(_ sender: Any) {
        guard var btnclr = self.thoughtButton.backgroundColor else { return }
        if btnclr == .mainRed {
            btnclr = .white
        } else {
            btnclr = .mainRed
        }
        print("oh fuck")
    }
//    @objc
//    func userDidTapIcon(_ sender: Any) {
//        print ("user tapped icon in child view")
//        guard let delegate = delegate else { return }
//        print (delegate)
//        delegate.userDidTapQuickAddIcon()
//    }
}
