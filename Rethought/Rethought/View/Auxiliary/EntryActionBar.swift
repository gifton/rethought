//
//  EntryActionBar.swift
//  Rethought
//
//  Created by Dev on 6/7/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryActionBar: UIView {
    init(withOrigin origin: CGPoint, thoughtIcon icon: ThoughtIcon) {
        self.icon = icon
        super.init(frame: CGRect(origin: origin, size: CGSize(width: Device.size.width - 30, height: 65)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private variables
    var icon: ThoughtIcon
    
    // MARK: private objects
    private var iconLabel = UILabel()
    private var infoView = UIView()
    
    // MARK: public objects
    public var closeButton = UIButton()
    public var deleteButton = UIButton()
    
    private func setViews() {
        // style views
        closeButton.layer.cornerRadius = 55.0/2
        closeButton.setImage(#imageLiteral(resourceName: "close-1"), for: .normal)
        iconLabel.font = .boldSystemFont(ofSize: Device.fontSize.emojiLG.rawValue)
        iconLabel.text = icon.icon
        infoView.backgroundColor = Device.colors.blue
        infoView.layer.cornerRadius = 65.0 / 2
        
        // add frames
        infoView.frame = CGRect(x: 0, y: 0, width: frame.width * 0.556, height: 65)
        closeButton.frame = CGRect(x: infoView.frame.width - 60, y: 5, width: 55, height: 55)
        iconLabel.frame = CGRect(x: 10, y: 5, width: 55, height: 55)
        deleteButton.frame = CGRect(x: ((frame.width - infoView.frame.width) - 60) / 2, y: 20, width: 60, height: 25)
        
        // add views
        addSubview(infoView)
        addSubview(deleteButton)
        infoView.addSubview(iconLabel)
        infoView.addSubview(closeButton)
    }
}
