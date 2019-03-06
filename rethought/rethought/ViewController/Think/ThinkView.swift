//
//  ThinkView.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThinkView: UIScrollView {
    init(with connector: ThinkDelegate) {
        super.init(frame: CGRect(x: 0, y: 10, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 120))        
        
        isScrollEnabled = true
        contentSize.height = ViewSize.SCREEN_HEIGHT - (ViewSize.SCREEN_HEIGHT * 0.21)
        showsVerticalScrollIndicator = false
        
        backgroundColor = UIColor(hex: "f7f7f7")
        self.connector = connector
        newThoughtView = NewThoughtView(frame: CGRect(x: 0, y: frame.height - 200, width: 0, height: 0))
        buildView()
    }
    
    var connector: ThinkDelegate!
    var newThoughtView: NewThoughtView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        addSubview(newThoughtView)
    }
}


