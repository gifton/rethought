//
//  ThoughtDetailHead.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailHead: AnimatableView {
    init(startFrame: CGRect, endFrame: CGRect) {
        super.init(frame: startFrame)
        self.startFrame = startFrame
        self.endFrame = endFrame
        
        setView()
        
    }
    
    let tf: UITextField = {
        let tf = UITextField()
        tf.text = "🚦"
        tf.font = Device.font.body(ofSize: .emojiSM)
        tf.backgroundColor = .white
        tf.textAlignment = .center
        tf.layer.cornerRadius = 8
        
        return tf
    }()
    
    let sb: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = .clear
        sb.backgroundImage = UIImage()
        
        return sb
    }()
    
    private func setView() {
        
        backgroundColor = Device.colors.offWhite
        layer.cornerRadius = 27.5
        
        addSubview(tf)
        addSubview(sb)
        tf.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 45, paddingLeading: 25)
        tf.setHeightWidth(width: 40, height: 40)
        sb.setAnchor(top: topAnchor, leading: tf.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 50, paddingLeading: 50, paddingBottom: 15, paddingTrailing: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


