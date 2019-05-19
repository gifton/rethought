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
//    let startBGColor = UIColor(hex: "361054")
//    let finishBGColor = UIColor(hex: "132544")
    let startBGColor = UIColor(hex: "#2C7699")
    let finishBGColor = UIColor(hex: "#4C3EC1")
    let dateTextColorStart = UIColor.white
    let dateTextColorFinish = UIColor.black
    var gradient: CAGradientLayer
    //frames
    let dateStartFrame = CGRect(x: 25, y: 100, width: 200, height: 18)
    let dateEndFrame = CGRect(x: 225, y: 65, width: 200, height: 18)
    let collectionStartFrame = CGRect(x: 0, y: 165, width: Device.size.width, height: 185)
    let collectionFinishFrame = CGRect(x: 0, y: -165, width: Device.size.width, height: 185)
    
    let rethoughtLabel = UILabel()
    let dateLabel = UILabel()
    let thoughtCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 185)
        layout.minimumLineSpacing = 5
        let cv = UICollectionView(frame: CGRect(x: 0, y: 165, width: Device.size.width, height: 185), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    let entryPickerView = UIView()
    
    func setView() {
        
        thoughtCollection.delegate = self
        thoughtCollection.dataSource = self
        thoughtCollection.register(cellWithClass: collectionCell.self)
        
        addSubview(thoughtCollection)
        addSubview(rethoughtLabel)
        addSubview(dateLabel)
        addSubview(entryPickerView)
        
        rethoughtLabel.frame = CGRect(x: 25, y: 50, width: 200, height: 42)
        dateLabel.frame = dateStartFrame
        
        entryPickerView.translatesAutoresizingMaskIntoConstraints = false
        entryPickerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        entryPickerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        entryPickerView.setHeightWidth(width: frame.width, height: 80)
    }
    
    private func styleView() {
//        backgroundColor = Device.colors.blue
        rethoughtLabel.text = "Rethought"
        rethoughtLabel.font = Device.font.title(ofSize: .emojiLG)
        rethoughtLabel.textColor = .white
        
        dateLabel.getStringFromDate(date: Date(), withStyle: .full)
        dateLabel.textColor = .white
        dateLabel.font = Device.font.body(ofSize: .medium)
        
        thoughtCollection.backgroundColor = .clear
        entryPickerView.backgroundColor = UIColor.white.withAlphaComponent(0.05)
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
            thoughtCollection.frame = collectionFinishFrame
        case 0:
            frame.size.height = startHeight
            gradient.frame = frame
            gradient.colors = [startBGColor.cgColor, finishBGColor.cgColor]
            dateLabel.frame = dateStartFrame
            thoughtCollection.alpha = 1.0
            thoughtCollection.frame = collectionStartFrame
        default:
            thoughtCollection.alpha = (1 - progress) * 1.25
            // set all views with animations here
            dateLabel.frame = CGRect(x: dateStartFrame.origin.x + (dateEndFrame.origin.x - dateStartFrame.origin.x) * progress,
                                     y: dateStartFrame.origin.y + (dateEndFrame.origin.y - dateStartFrame.origin.y) * progress,
                                     width: dateEndFrame.width, height: dateEndFrame.height)
            thoughtCollection.frame = CGRect(x: collectionStartFrame.origin.x + (collectionFinishFrame.origin.x - collectionStartFrame.origin.x) * progress,
                                     y: collectionStartFrame.origin.y + (collectionFinishFrame.origin.y - collectionStartFrame.origin.y) * progress,
                                     width: collectionFinishFrame.width, height: collectionFinishFrame.height)
            
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
        return collectionView.dequeueReusableCell(withClass: collectionCell.self, for: indexPath)
    }
    
    
}

class collectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        isOpaque = false
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
        
        layoutIfNeeded()
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updatePath()
    }
    
    var radius: CGFloat = 28.5
    private var path: UIBezierPath?
    
    override func draw(_ rect: CGRect) {
        guard let path = path,
            let context = UIGraphicsGetCurrentContext() else {
                print("returning")
                return
        }
        
        context.clear(rect)
        UIColor.black.withAlphaComponent(0.34).setFill()
        path.fill()
    }
    
    private func updatePath() {
        let path = UIBezierPath.continuousRoundedRect(bounds, cornerRadius: (topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius))
        
        layer.shadowPath = path.cgPath
        
        self.path = path
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
