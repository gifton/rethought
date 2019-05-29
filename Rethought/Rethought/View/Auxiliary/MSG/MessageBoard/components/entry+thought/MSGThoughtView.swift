//
//  MSGThoughtView.swift
//  Rethought
//
//  Created by Dev on 4/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MSGThoughtView: MSGBoardComponent {
    init(frame: CGRect, title: String) {
        thoughtTitle = title
        super.init(frame: frame)
        setView()
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    var thoughtTitle: String
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var thoughtIconLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "💭"
        lbl.backgroundColor = .black
        lbl.font = Device.font.mediumTitle(ofSize: .emojiLG)
        lbl.textAlignment = .center
        lbl.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        lbl.layer.cornerRadius = 19
        lbl.layer.masksToBounds = true
        
        return lbl
    }()
    var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = Device.font.mediumTitle(ofSize: .large)
        lbl.textColor = Device.colors.lightGray
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .right
        
        return lbl
    }()
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Device.font.mediumTitle(ofSize: .large)
        lbl.textColor = Device.colors.lightGray
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .right
        
        return lbl
    }()
    func setView() {
        thoughtIconLabel.frame = CGRect(x: frame.width - 70, y: 0, width: 55, height: 55)
        contentLbl.text = thoughtTitle
        addSubview(thoughtIconLabel)
        addSubview(contentLbl)
        contentLbl.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: thoughtIconLabel.leadingAnchor, paddingTop: 0, paddingLeading: 15, paddingBottom: 0, paddingTrailing: 10)
        
    }
}
