//
//  ThoughtDetailTableHead.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailTableHead: UITableViewCell, Animatable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView(); setView()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private objects
    var titleLabel = AnimatableLabel()
    
    // sizes for animation
    let endHeight = 100
    let endTitlePoint = CGPoint(x: 15, y: 225)
    var titleStartPoint = CGPoint(x: 15, y: 10)
    var titleSize = CGSize.zero
    
    func styleView() {
        titleLabel.text = "Whats the square root of 69? 8 something?"
        titleLabel.font = Device.font.mediumTitle(ofSize: .xXXLarge)
        titleLabel.numberOfLines = 0
        
        print(titleLabel.frame)
        
    }
    
    func setView() {
        let size = titleLabel.text!.sizeFor(font: Device.font.mediumTitle(ofSize: .xXXLarge),
                                            width: Device.size.width - 50)
        titleSize = size
        print(size)
        titleLabel.frame = CGRect(origin: titleStartPoint, size: size)
        print(titleLabel.frame)
        
        titleLabel.endFrame = CGRect(origin: endTitlePoint, size: titleSize)
        titleLabel.startFrame = CGRect(origin: titleStartPoint, size: titleSize)
        addSubview(titleLabel)
        
    }
    
    
    
    func update(toAnimationProgress progress: CGFloat) {
        titleLabel.update(toAnimationProgress: progress)
        updateConstraints()
        updateFocusIfNeeded()
    }
}
