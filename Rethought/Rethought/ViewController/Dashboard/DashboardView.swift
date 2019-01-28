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
    //conect to controller
    private var dDelegate: DashboardDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightBackground
        
        self.backgroundColor = UIColor(hex: "F9FCFF")
    }
    convenience init(delegate: DashboardDelegate, frame: CGRect) {
        self.init(frame: frame)
        self.dDelegate = delegate
        self.setupTV()
    }
    
    let thoughtCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (ViewSize.SCREEN_WIDTH / 2) - 7.5, height: (ViewSize.SCREEN_WIDTH / 2) - 7.5)
        layout.sectionInsetReference = .fromContentInset
        layout.headerReferenceSize = CGSize(width: ViewSize.SCREEN_WIDTH - 20, height: 220)
        layout.minimumInteritemSpacing = 2.5
        layout.minimumLineSpacing = 5
        
        let cv = UICollectionView(frame: CGRect(x: 5, y: 35, width: ViewSize.SCREEN_WIDTH - 10, height: ViewSize.SCREEN_HEIGHT - 35), collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.keyboardDismissMode = .interactive
        
        print(layout.estimatedItemSize)
        print("-------------------------")
        print(cv.frame)
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DashboardView {
    
    //register cells and head
    func setupTV() {
        
        thoughtCollectionView.register(ThoughtFeedCellTile.self, forCellWithReuseIdentifier: ThoughtFeedCellTile.identifier)
        thoughtCollectionView.register(DashboardHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DashboardHeader.identifier)
        
        //add to superView
        addSubview(thoughtCollectionView)
        
    }
}
