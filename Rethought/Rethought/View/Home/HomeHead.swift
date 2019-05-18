//
//  HomeHeadView.swift
//  Rethought
//
//  Created by Dev on 5/16/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeHead: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView(); styleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let startHeight = CGFloat(500)
    let endHeight = CGFloat(170)
    let startColor = UIColor(hex: "2C7699")
    let finishColor = Device.colors.red
    
    let rethoughtLabel = UILabel()
    let dateLabel = UILabel()
    let thoughtCollection = UIView()
    let entryPickerView = UIView()
    
    func setView() {
        
        addSubview(rethoughtLabel)
        addSubview(dateLabel)
        addSubview(entryPickerView)
        rethoughtLabel.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 50, paddingLeading: 25)
        dateLabel.setTopAndLeading(top: rethoughtLabel.bottomAnchor, leading: leadingAnchor, paddingTop: 10, paddingLeading: 25)
        entryPickerView.setAnchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        entryPickerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func styleView() {
        backgroundColor = Device.colors.blue
        rethoughtLabel.text = "Rethought"
        rethoughtLabel.font = Device.font.title(ofSize: .emojiLG)
        rethoughtLabel.textColor = .white
        
        dateLabel.getStringFromDate(date: Date(), withStyle: .full)
        dateLabel.textColor = .white
        dateLabel.font = Device.font.body(ofSize: .medium)
        
        thoughtCollection.backgroundColor = Device.colors.lightClay
        entryPickerView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
    }
}

extension HomeHead: Animatable {
    
    func update(toAnimationProgress progress: CGFloat) {
        
        //calculate height delta from progress
        let newHeight: CGFloat = ((startHeight - endHeight) * progress)
        // calculate background color
        switch progress {
        case 1:
            backgroundColor = finishColor
        case 0:
            frame.size.height = startHeight
            backgroundColor = startColor
        default:
            frame.size.height = startHeight - newHeight
            backgroundColor = UIColor(red: startColor.rgba.red + (finishColor.rgba.red - startColor.rgba.red) * progress,
                                      green: startColor.rgba.green + (finishColor.rgba.green - startColor.rgba.green) * progress,
                                      blue: startColor.rgba.blue + (finishColor.rgba.blue - startColor.rgba.blue) * progress,
                                      alpha: startColor.rgba.alpha + (finishColor.rgba.alpha - startColor.rgba.alpha) * progress)
        }
        
    }
}
