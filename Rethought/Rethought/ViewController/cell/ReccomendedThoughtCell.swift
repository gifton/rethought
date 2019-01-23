//
//  MicroThoughtCell.swift
//  rethought
//
//  Created by Dev on 12/20/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ReccomendedThoughtCellMicro: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private var icon = UILabel(frame: CGRect(x: 10, y: 5, width: 25, height: 25))
    private var daysSinceLabel = UILabel(frame: CGRect(x: 0, y: 35, width: 80, height: 20))
    private var entryType = UIImageView(frame: CGRect(x: 50, y: 5, width: 25, height: 25))
    
    override func layoutSubviews() {
        backgroundColor = UIColor.cardBackground.withAlphaComponent(0.15)
        self.layer.cornerRadius = 3
        
        addSubview(icon)
        addSubview(daysSinceLabel)
        addSubview(entryType)
        
        daysSinceLabel.font = .reBodyLight(ofSize: 12)
        daysSinceLabel.textAlignment = .center
    }
    //MARK CHANGE ENTRY PTREVIEW TO INCLUDE THOUGHT ICON
    public func giveContext(_ entry: ReccomendedThought) {
        self.icon.text = entry.icon.icon
        self.daysSinceLabel.getStringFromDate(date: entry.daysSinceLastEdit)
        switch entry.lastEntryType {
        case .text:
            self.entryType.image = #imageLiteral(resourceName: "pen-square")
        case .image:
            self.entryType.image = #imageLiteral(resourceName: "camera-alt")
        case .link:
            self.entryType.image = #imageLiteral(resourceName: "link")
        default:
            self.entryType.image = #imageLiteral(resourceName: "microphone")
            self.entryType.frame.size.height += 4
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.entryType.image = UIImage()
        self.daysSinceLabel.text = ""
        self.icon.text = ""
    }
    
    public static var identifier: String { return "MicroThoughtCell" }
    
}
