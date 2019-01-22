//
//  MicroThoughtCell.swift
//  rethought
//
//  Created by Dev on 12/20/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RecentEntryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private var icon = UIImageView(frame: CGRect(x: 5, y: 2, width: 25, height: 25))
    private var daysSinceLabel = UILabel(frame: CGRect(x: 35, y: 25, width: 65, height: 15))
    
    override func layoutSubviews() {
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.layer.cornerRadius = 3
        
        addSubview(icon)
        addSubview(daysSinceLabel)
        
        daysSinceLabel.font = .reBodyLight(ofSize: 12)
    }
    //MARK CHANGE ENTRY PTREVIEW TO INCLUDE THOUGHT ICON
    public func giveContext(_ entry: EntryPreview) {
//        self.icon.imaget
        self.daysSinceLabel.getStringFromDate(date: entry.date)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String { return "MicroThoughtCell" }
    
}
