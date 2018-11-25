//
//  DashboardView.swift
//  ReThought
//
//  Created by Dev on 11/17/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DashboardView: UIView {
    
    let cellIdentifier = "collectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "0E253D")
        buildCellWithoutContext()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let recordCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: ScreenSize.SCREEN_WIDTH - 25, height: ScreenSize.SCREEN_HEIGHT - 200)
        let cv = UICollectionView(frame: CGRect(x: 10, y: 0, width: ScreenSize.SCREEN_WIDTH - 20, height: ScreenSize.SCREEN_HEIGHT), collectionViewLayout: layout)
        cv.allowsSelection = false
        cv.isSpringLoaded = false
        cv.isPagingEnabled = true
        cv.backgroundColor = UIColor(hex: "0E253D")
        
        return cv
    }()
    
    func buildCellWithoutContext() {
        addSubview(recordCollection)
        recordCollection.delegate = self
        recordCollection.dataSource = self
        recordCollection.register(DashboardCell.self, forCellWithReuseIdentifier: cellIdentifier)
        print("hi we made it!")
    }
}
