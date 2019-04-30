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
    }
    
    var thoughtTitle: String
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var thoughtIconLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
        lbl.text = "💭"
        lbl.backgroundColor = .white
        lbl.font = Device.font.body(ofSize: .emojiLG)
        lbl.textAlignment = .center
        lbl.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        lbl.layer.cornerRadius = 10
        lbl.layer.masksToBounds = true
        
        return lbl
    }()
    var userLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 46, y: 2, width: 150, height: 18))
        lbl.font = Device.font.mediumTitle(ofSize: .large)
        lbl.text = "Rethought"
        
        return lbl
    }()
    var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = Device.font.body(ofSize: .large)
        lbl.textColor = Device.colors.darkGray
        lbl.frame = CGRect(x: 46, y: 22, width: 300, height: 18)
        
        return lbl
    }()
    func setView() {
        contentLbl.text = thoughtTitle
        addSubview(thoughtIconLabel)
        addSubview(userLbl)
        addSubview(contentLbl)
        
    }
}
