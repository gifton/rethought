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
//        addSubview(gradient)
        backgroundColor = .black
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
    private let startHeight = CGFloat(500)
    let endHeight = CGFloat(170)
    //colors
    private let startBGColor = UIColor(hex: "#2C7699")
    private let finishBGColor = UIColor(hex: "#4C3EC1")
    private let dateTextColorStart = UIColor.white
    private let dateTextColorFinish = Device.colors.green
    //frames
    private let dateStartFrame = CGRect(x: 25, y: 90, width: 200, height: 18)
    private var dateEndFrame = CGRect(x: 225, y: 65, width: 200, height: 18)
    
    // labels
    private let rethoughtLabel = AnimatableLabel()
    public let dateLabel = AnimatableLabel()
    
    private var gradient: RadialGradientView
    
    // horizontally scrolling collectionView
    public let thoughtCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 210)
        layout.minimumLineSpacing = 25
        
        let cv = UICollectionView(frame: CGRect(x: 5, y: 160, width: Device.size.width - 10, height: 210), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    // select specific entry types here
    private let entryPickerView = EntryScrollView(frame: .zero)
    
    private func setView() {
        
        // set collection
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
        
        
        dateLabel.startColor = dateTextColorStart
        dateLabel.endColor = dateTextColorFinish
        dateLabel.startFrame = dateStartFrame
        dateLabel.endFrame = dateEndFrame
        
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
            thoughtCollection.alpha = 0.0
            entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
        case 0:
            frame.size.height = startHeight
            thoughtCollection.alpha = 1.0
            entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
        default:
            entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
            thoughtCollection.alpha = (1 - progress * 2)
            frame.size.height = startHeight - newHeight
        }
        
        
        print(frame.height)
        dateLabel.update(toAnimationProgress: progress)
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
