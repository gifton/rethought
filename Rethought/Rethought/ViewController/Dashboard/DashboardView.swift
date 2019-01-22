//
//  DashboardView.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DashboardView: UIView {
    private var delegate: DashboardDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGBackgroundGradientTo(view: self)
    }
    convenience init(delegate: DashboardDelegate, frame: CGRect) {
        self.init(frame: frame)
        self.delegate = delegate
        self.setupTV()
    }
    
    let thoughtCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = ViewSize.thoughtTileSize
        
        let cv = UICollectionView(frame: CGRect(x: 0, y: 50, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 50), collectionViewLayout: layout)
        cv.contentSize = ViewSize.thoughtTileSize
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .blue
        cv.showsVerticalScrollIndicator = false
        cv.flashScrollIndicators()
        
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DashboardView {
    func setupTV() {
        thoughtCollectionView.register(ThoughtFeedCellTile.self, forCellWithReuseIdentifier: ThoughtFeedCellTile.identifier)
        addSubview(thoughtCollectionView)
    }
}
