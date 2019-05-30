//
//  ThoughtDetailTableHead.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailTableHead: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView(); StyleView()
        backgroundColor = Device.colors.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel = UILabel()
    let endHeight = 100
    
    func setView() {
        titleLabel.frame = CGRect(x: 25, y: 50, width: Device.size.width - 50, height: 200)
        addSubview(titleLabel)
    }
    
    func StyleView() {
        titleLabel.text = "Whats the square root of 69? 8 something?"
        titleLabel.font = Device.font.title()
        titleLabel.numberOfLines = 0
    }
}
