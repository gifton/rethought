//
//  MicroThoughtCell.swift
//  rethought
//
//  Created by Dev on 12/20/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MicroThoughtCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private var icon = UILabel(frame: CGRect(x: 5, y: 14, width: 25, height: 25))
    private var daysSinceLabel = UILabel(frame: CGRect(x: 35, y: 25, width: 65, height: 15))
    private var itemCountLabel = UILabel(frame: CGRect(x: 35, y: 10, width: 65, height: 15))
    
    override func layoutSubviews() {
        backgroundColor = UIColor(hex: "EFEFEF")
        self.layer.cornerRadius = 3
        
        addSubview(icon)
        addSubview(daysSinceLabel)
        addSubview(itemCountLabel)
        
        icon.font = UIFont.boldSystemFont(ofSize: 20)
        daysSinceLabel.font = .reBodyLight(ofSize: 12)
        itemCountLabel.font = .reBody(ofSize: 12)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        formatter.formattingContext = .standalone
        return formatter
    }()
    
    public func configureCell(_ thought: ThoughtPreviewSmall) {
        self.icon.text = thought.icon
        self.daysSinceLabel.text = dateFormatter.string(from: thought.lastEdited)
        self.itemCountLabel.text = thought.itemCount
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String { return "MicroThoughtCell" }
    
}
