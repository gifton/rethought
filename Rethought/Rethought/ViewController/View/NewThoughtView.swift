//
//  NewThoughtView.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class NewThoughtView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "FAFBFF")
        
    }
    
    let createThought: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 100, width: ViewSize.SCREEN_WIDTH, height: 100))
        btn.backgroundColor = UIColor(hex: "F7D351")
        btn.setTitle("Create Thought", for: .normal)
        return btn
    }()
    
    func setLayout() {
        addSubview(createThought)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
