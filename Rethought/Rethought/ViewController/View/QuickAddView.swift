//
//  QuickAddView.swift
//  rethought
//
//  Created by Dev on 12/14/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class QuickAddView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init(frame: CGRect, delegate: HomeViewControllerDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
    }
    
    public var delegate: HomeViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let textView = UITextView(frame: CGRect(x: 50, y: 25, width: ViewSize.SCREEN_WIDTH - 70, height: 30))
    let recentThought = UIButton(frame: CGRect(x: 10, y: 25, width: 30, height: 30))
}

extension QuickAddView: UITextViewDelegate {
    fileprivate func styleView() {
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 5
        textView.text = "Whats on your mind?"
        textView.textColor = .lightGray
        recentThought.setTitle("🎄", for: .normal)
        recentThought.backgroundColor = UIColor(hex: "C4C4C4")
        recentThought.layer.cornerRadius = 2
    }
    fileprivate func setupView() {
        self.backgroundColor = UIColor(hex: "E0E1E9")
        textView.delegate = self
        
        addSubview(textView)
        addSubview(recentThought)
        
        recentThought.addTarget(self, action: #selector(userDidTapIcon(_:)), for: .touchUpInside)
        
        styleView()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        self.frame.size.height += 300
        self.frame.origin.y -= 300
        
        userDidTapTextView()
    }
    @objc func userDidTapIcon(_ sender: Any) {
        print ("user tapped icon in child view")
        guard let delegate = delegate else { return }
        print (delegate)
        delegate.userDidTapQuickAddIcon()
    }
    private func userDidTapTextView() {
        guard let delegate = delegate else { return }
        delegate.userBeganQuickAdd()
    }
}
