//
//  DashboardView.swift
//  ReThought
//
//  Created by Dev on 11/17/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MasterView: UIView {
    
    let cellIdentifier = "collectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundWhite
        buildCellWithoutContext()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let MasterCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT - 150)
        let cv = UICollectionView(frame: CGRect(x: 0, y: 70, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT - 150), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.allowsSelection = false
        cv.isSpringLoaded = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .mainRed
        
        return cv
    }()
    let titleLabel = UILabel()
    let newButton = UIButton()
    
    func buildCellWithoutContext() {
        addSubview(MasterCollection)
        addSubview(titleLabel)
        titleLabel.text = "Profile"
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize.xXLarge.rawValue)
        titleLabel.frame = CGRect(x: 10, y: 30, width: 400, height: 35)
        MasterCollection.delegate = self
        MasterCollection.dataSource = self
        MasterCollection.register(MasterCell.self, forCellWithReuseIdentifier: MasterCell.identifier)
        MasterCollection.register(DashCell.self, forCellWithReuseIdentifier: DashCell.identifier)
        print("hi we made it!")
    }
}
