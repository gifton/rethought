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
        gradient = RadialGradientView(frame: frame)
        super.init(frame: frame)
        gradient.colors = [UIColor(hex: "1A2437"), UIColor(hex: "381055"), UIColor(hex: "14263F"), UIColor(hex: "122450")]
        addSubview(gradient)
        setView(); styleView()
    }
    
    private func setGradientView() {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 200, height: 200))
        let gradient = CAGradientLayer()
        gradient.frame = path.bounds
        gradient.colors = [UIColor.magenta.cgColor, UIColor.cyan.cgColor]
        let shapeMask = CAShapeLayer()
        shapeMask.path = path.cgPath
        gradient.mask = shapeMask
        layer.addSublayer(gradient)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK animation variables
    //floats
    let startHeight = CGFloat(500)
    let endHeight = CGFloat(170)
    //colors
    let startBGColor = UIColor(hex: "#2C7699")
    let finishBGColor = UIColor(hex: "#4C3EC1")
    let dateTextColorStart = UIColor.white
    let dateTextColorFinish = Device.colors.green
    //frames
    let dateStartFrame = CGRect(x: 25, y: 90, width: 200, height: 18)
    let dateEndFrame = CGRect(x: 225, y: 65, width: 200, height: 18)
    
    // labels
    let rethoughtLabel = UILabel()
    let dateLabel = UILabel()
    
    var gradient: RadialGradientView
    
    // horizontally scrolling collectionView
    public let thoughtCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 165)
        layout.minimumLineSpacing = 5
        let cv = UICollectionView(frame: CGRect(x: 5, y: 200, width: Device.size.width - 10, height: 170), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    // select specific entry types here
    let entryPickerView = EntryScrollView(frame: .zero)
    
    func setView() {
        
        // set collection
        thoughtCollection.delegate = self
        thoughtCollection.register(cellWithClass: ThoughtCollectionCell.self)
        
        // add subviews
        addSubview(thoughtCollection)
        addSubview(rethoughtLabel)
        addSubview(dateLabel)
        addSubview(entryPickerView)
        
        // set frames
        rethoughtLabel.frame = CGRect(x: 25, y: 50, width: 200, height: 42)
        dateLabel.frame = dateStartFrame
        
        // TODO: update to sue frame and animate instead of
        entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
    }
    
    private func styleView() {
        rethoughtLabel.text = "Rethought"
        rethoughtLabel.font = Device.font.title(ofSize: .emojiLG)
        rethoughtLabel.textColor = .white
        
        dateLabel.getStringFromDate(date: Date(), withStyle: .full)
        dateLabel.textColor = .white
        dateLabel.font = Device.font.body(ofSize: .medium)
        
        thoughtCollection.backgroundColor = .clear
    }
}

extension HomeHead: Animatable {
    
    func update(toAnimationProgress progress: CGFloat) {
        
        //calculate height delta from progress
        let newHeight: CGFloat = ((startHeight - endHeight) * progress)
        // calculate background color
        switch progress {
        case 1:
            frame.size.height = endHeight
            dateLabel.frame = dateEndFrame
            thoughtCollection.alpha = 0.0
            entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
        case 0:
            frame.size.height = startHeight
            dateLabel.frame = dateStartFrame
            thoughtCollection.alpha = 1.0
            entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
        default:
            entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
            thoughtCollection.alpha = (1 - progress * 2)
            frame.size.height = startHeight - newHeight
            
            // set all views with animations here
            dateLabel.frame = CGRect(x: dateStartFrame.origin.x + (dateEndFrame.origin.x - dateStartFrame.origin.x) * progress,
                                     y: dateStartFrame.origin.y + (dateEndFrame.origin.y - dateStartFrame.origin.y) * progress,
                                     width: dateEndFrame.width, height: dateEndFrame.height)
            
            dateLabel.textColor = UIColor(red: dateTextColorStart.rgba.red + (dateTextColorFinish.rgba.red - dateTextColorStart.rgba.red) * progress,
                                          green: dateTextColorStart.rgba.green + (dateTextColorFinish.rgba.green - dateTextColorStart.rgba.green) * progress,
                                          blue: dateTextColorStart.rgba.blue + (dateTextColorFinish.rgba.blue - dateTextColorStart.rgba.blue) * progress,
                                          alpha: dateTextColorStart.rgba.alpha + (dateTextColorFinish.rgba.alpha - dateTextColorStart.rgba.alpha) * progress)
        }
        
    }
    
    func animatedColors(withProgress progress: CGFloat) ->  [CGColor]{
        return [UIColor(red: startBGColor.rgba.red + (finishBGColor.rgba.red - startBGColor.rgba.red) * progress,
                        green: startBGColor.rgba.green + (finishBGColor.rgba.green - startBGColor.rgba.green) * progress,
                        blue: startBGColor.rgba.blue + (finishBGColor.rgba.blue - startBGColor.rgba.blue) * progress,
                        alpha: startBGColor.rgba.alpha + (finishBGColor.rgba.alpha - startBGColor.rgba.alpha) * progress).cgColor,
                UIColor(red: finishBGColor.rgba.red + (startBGColor.rgba.red - finishBGColor.rgba.red) * progress,
                        green: finishBGColor.rgba.green + (startBGColor.rgba.green - finishBGColor.rgba.green) * progress,
                        blue: finishBGColor.rgba.blue + (startBGColor.rgba.blue - finishBGColor.rgba.blue) * progress,
                        alpha: startBGColor.rgba.alpha + (startBGColor.rgba.alpha - finishBGColor.rgba.alpha) * progress).cgColor]
    }
}

extension HomeHead: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
