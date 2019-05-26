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
        let gView = RadialGradientView(frame: frame)
        gView.colors = [UIColor(hex: "1A2437"), UIColor(hex: "381055"), UIColor(hex: "14263F"), UIColor(hex: "122450")]
        addSubview(gView)
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
    let entryLabel = UILabel()
    
    // horizontally scrolling collectionView
    let thoughtCollection: UICollectionView = {
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
            dateLabel.frame = dateEndFrame
            thoughtCollection.alpha = 0.0
        case 0:
            frame.size.height = startHeight
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




class RadialGradientLayer: CALayer {
    
    var center: CGPoint {
        return CGPoint(x: bounds.width/2, y: bounds.height/2)
    }
    
    var radius: CGFloat {
        return (bounds.width + bounds.height)/2
    }
    
    var colors: [UIColor] = [UIColor.black, UIColor.lightGray] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var cgColors: [CGColor] {
        return colors.map({ (color) -> CGColor in
            return color.cgColor
        })
    }
    
    override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 0.33, 0.66, 1.0]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            return
        }
        ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
    }
    
}



class RadialGradientView: UIView {
    
    private let gradientLayer = RadialGradientLayer()
    
    var colors: [UIColor] {
        get {
            return gradientLayer.colors
        }
        set {
            gradientLayer.colors = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.superlayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }
        gradientLayer.frame = bounds
    }
    
}
