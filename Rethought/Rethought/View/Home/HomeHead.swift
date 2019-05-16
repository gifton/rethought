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
        backgroundColor = Device.colors.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let startHeight = CGFloat(390)
    let endHeight = CGFloat(170)
}

extension HomeHead: Animatable {
    func update(toAnimationProgress progress: CGFloat) {
        //calculate height delta from progress
        let newHeight: CGFloat = ((startHeight - endHeight) * progress)
        if progress == 0.0 {
            frame.size.height = startHeight
        } else {
            frame.size.height = startHeight - newHeight
        }
        
//        print("newHeight: \(newHeight), forProgress: \(progress)")
        
        
    }
}
