//
//  ThoughtDetailTable.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailTable: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Device.colors.blue
        setView()
    }
    
    public let tv: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: Device.size.height - 100))
        tv.allowsSelection = true
        tv.rowHeight = UITableView.automaticDimension
        tv.separatorInset = .zero
        tv.backgroundColor = Device.colors.red
        
        return tv
    }()
    
    private func setView() {
        addSubview(tv)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
