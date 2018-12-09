//
//  HomeView.swift
//  rethought
//
//  Created by Dev on 12/8/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "FAFBFF")
        buildStaticObjects()
    }
    
    let newView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: (ScreenSize.SCREEN_HEIGHT) - 100, width: ScreenSize.SCREEN_WIDTH, height: 100))
        view.backgroundColor = UIColor(hex: "F7D351")
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildStaticObjects() {
        addSubview(newView)
    }
}
