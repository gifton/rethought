//
//  EntryTypeView.swift
//  rethought
//
//  Created by Dev on 2/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryTypeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    let types = ["text", "image", "linnk", "recording"]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        let views = [UIView]()
        for type in types {
            let view = UIView()
            view.frame.size = CGSize(width: 100, height: 27)
        }
        buildStack(views: views)
    }
    
    func buildStack(views: [UIView]) {
        
    }
    
}
