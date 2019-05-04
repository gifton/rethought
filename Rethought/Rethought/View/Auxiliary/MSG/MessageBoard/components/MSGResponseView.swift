//
//  MSGResponseView.swift
//  Rethought
//
//  Created by Dev on 4/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ResponseMessage: MSGBoardComponent {
    var content: String
    
    init(frame: CGRect, content: String) {
        self.content = content
        super.init(frame: CGRect(x: 15, y: frame.origin.y, width: frame.width, height: frame.height))
        self.componentType = .rethoughtResponse
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var rtIcon: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        lbl.text = "💭"
        lbl.backgroundColor = .white
        lbl.font = Device.font.body(ofSize: .emojiSM)
        lbl.textAlignment = .center
        lbl.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        lbl.layer.cornerRadius = 15
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
        contentLbl.text = content
        addSubview(rtIcon)
        addSubview(userLbl)
        addSubview(contentLbl)
        
    }
}
