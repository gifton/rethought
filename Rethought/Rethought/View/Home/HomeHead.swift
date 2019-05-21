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
        gradient = CAGradientLayer()
        super.init(frame: frame)
        gradient.frame = frame
        gradient.colors = [startBGColor.cgColor, finishBGColor.cgColor]
        layer.addSublayer(gradient)
        
        setView(); styleView()
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
    let dateTextColorFinish = UIColor.black
    var gradient: CAGradientLayer
    //frames
    let dateStartFrame = CGRect(x: 25, y: 90, width: 200, height: 18)
    let dateEndFrame = CGRect(x: 225, y: 65, width: 200, height: 18)
    let collectionStartFrame = CGRect(x: 5, y: 200, width: Device.size.width, height: 170)
    let collectionFinishFrame = CGRect(x: 5, y: -165, width: Device.size.width, height: 170)
    
    // labels
    let rethoughtLabel = UILabel()
    let dateLabel = UILabel()
    let entryLabel = UILabel()
    
    // horizontally scrolling collectionView
    let thoughtCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 165)
        layout.minimumLineSpacing = 5
        let cv = UICollectionView(frame: CGRect(x: 5, y: 200, width: Device.size.width, height: 170), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    // select specific entry types here
    let entryPickerView = EntryScrollView(frame: .zero)
    
    func setView() {
        
        // set collection
        thoughtCollection.delegate = self
        thoughtCollection.dataSource = self
        thoughtCollection.register(cellWithClass: ThoughtCollectionCell.self)
        
        // add subviews
        addSubview(thoughtCollection)
        addSubview(rethoughtLabel)
        addSubview(dateLabel)
        addSubview(entryPickerView)
        addSubview(entryLabel)
        
        // set frames
        rethoughtLabel.frame = CGRect(x: 25, y: 50, width: 200, height: 42)
        dateLabel.frame = dateStartFrame
        
        // TODO: update to sue frame and animate instead of
        entryPickerView.translatesAutoresizingMaskIntoConstraints = false
        entryPickerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        entryPickerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        entryPickerView.setHeightWidth(width: frame.width, height: 80)
        
        entryLabel.frame = CGRect(x: 15, y: frame.height - 70, width: 250, height: 30)
    }
    
    private func styleView() {
        rethoughtLabel.text = "Rethought"
        rethoughtLabel.font = Device.font.title(ofSize: .emojiLG)
        rethoughtLabel.textColor = .white
        
        dateLabel.getStringFromDate(date: Date(), withStyle: .full)
        dateLabel.textColor = .white
        dateLabel.font = Device.font.body(ofSize: .medium)
        
        thoughtCollection.backgroundColor = .clear
        
        entryLabel.text = "View your Entries"
        entryLabel.font = Device.font.mediumTitle(ofSize: .xXXLarge)
        entryLabel.textColor = .white
    }
}

extension HomeHead: Animatable {
    
    func update(toAnimationProgress progress: CGFloat) {
        
        //calculate height delta from progress
        let newHeight: CGFloat = ((startHeight - endHeight) * progress)
        // calculate background color
        switch progress {
        case 1:
            gradient.colors = [finishBGColor.cgColor, startBGColor.cgColor]
            dateLabel.frame = dateEndFrame
            thoughtCollection.alpha = 0.0
        case 0:
            frame.size.height = startHeight
            gradient.frame = frame
            gradient.colors = [startBGColor.cgColor, finishBGColor.cgColor]
            dateLabel.frame = dateStartFrame
            thoughtCollection.alpha = 1.0
        default:
            thoughtCollection.alpha = (1 - progress * 2)
            
            // set all views with animations here
            dateLabel.frame = CGRect(x: dateStartFrame.origin.x + (dateEndFrame.origin.x - dateStartFrame.origin.x) * progress,
                                     y: dateStartFrame.origin.y + (dateEndFrame.origin.y - dateStartFrame.origin.y) * progress,
                                     width: dateEndFrame.width, height: dateEndFrame.height)
            
            dateLabel.textColor = UIColor(red: dateTextColorStart.rgba.red + (dateTextColorFinish.rgba.red - dateTextColorStart.rgba.red) * progress,
                                          green: dateTextColorStart.rgba.green + (dateTextColorFinish.rgba.green - dateTextColorStart.rgba.green) * progress,
                                          blue: dateTextColorStart.rgba.blue + (dateTextColorFinish.rgba.blue - dateTextColorStart.rgba.blue) * progress,
                                          alpha: dateTextColorStart.rgba.alpha + (dateTextColorFinish.rgba.alpha - dateTextColorStart.rgba.alpha) * progress)

            frame.size.height = startHeight - newHeight
            gradient.frame = frame
            gradient.colors = animatedColors(withProgress: progress)
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

extension HomeHead: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withClass: ThoughtCollectionCell.self, for: indexPath)
    }
}
