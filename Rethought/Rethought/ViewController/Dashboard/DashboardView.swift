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
        layout.minimumLineSpacing = 5
        layout.estimatedItemSize = CGSize(width: ((ViewSize.SCREEN_WIDTH - 15) / 2) - 2.5, height: ((ViewSize.SCREEN_WIDTH - 15) / 2) - 2.5)
        layout.sectionInsetReference = .fromContentInset
        
        let cv = UICollectionView(frame: CGRect(x: 0, y: 220, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 220), collectionViewLayout: layout)
        cv.contentSize = CGSize(width: ((ViewSize.SCREEN_WIDTH - 10) / 2) + 2.5, height: ((ViewSize.SCREEN_WIDTH - 10) / 2) + 2.5)
        cv.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DashboardView {
    func setupTV() {
        thoughtCollectionView.register(ThoughtFeedCellTile.self, forCellWithReuseIdentifier: ThoughtFeedCellTile.identifier)
        thoughtCollectionView.register(DashboardHeader.self, forCellWithReuseIdentifier: DashboardHeader.identifier)
        addSubview(thoughtCollectionView)
        print (thoughtCollectionView.frame.size)
    }
}
