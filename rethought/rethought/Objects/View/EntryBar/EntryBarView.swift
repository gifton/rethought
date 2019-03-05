//
//  EntryBarView.swift
//  rethought
//
//  Created by Dev on 1/31/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntrybarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private var delegate: EntryBarDelegate?
    
    convenience init(delegate: EntryBarDelegate) {
        let newFrame = CGRect(x: ViewSize.SCREEN_WIDTH - 79, y: ViewSize.largeBar.origin.y, width: ViewSize.largeBar.size.width, height: ViewSize.largeBar.size.height)
        self.init(frame: newFrame)
        
        self.delegate = delegate
        styleCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func styleCell() {
        self.backgroundColor = UIColor(hex: "DBDADB")
        self.layer.cornerRadius = 6
        let leftView: UIView = {
            let v = UIView()
            v.frame = CGRect(x: 0, y: 0, width: ViewSize.largeBar.size.height, height: ViewSize.largeBar.size.height)
            v.backgroundColor = .white
            v.roundCorners(corners: [.topLeft, .bottomLeft], radius: 6)
            
            return v
        }()
        addSubview(leftView)
    }
}
