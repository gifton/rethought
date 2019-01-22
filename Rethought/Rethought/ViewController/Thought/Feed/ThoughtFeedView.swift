//
//  ThoughtFeedView.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtFeedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "FAFBFF")
        setupView()
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        addGestureRecognizer(edgePan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thoughtCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = ViewSize.thoughtTileSize
        
        let cv = UICollectionView(frame: CGRect(x: 30, y: 120, width: ViewSize.SCREEN_WIDTH - 60, height: ViewSize.SCREEN_HEIGHT - 120), collectionViewLayout: layout)
        cv.contentSize = ViewSize.thoughtTileSize
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.flashScrollIndicators()
        
        return cv
    }()
    private let logo: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 20, y: 50, width: 100, height: 30))
        iv.image = #imageLiteral(resourceName: "Logo_with_bg")
        iv.addLogoShadow()
        
        return iv
    }()
    private let allThoughtsLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 111, y: 57, width: 90, height: 20))
        lbl.font = .reBody(ofSize: 12)
        lbl.textColor = UIColor(hex: "BFC0C3")
        lbl.text = "ALL THOUGHTS"
        
        return lbl
    }()
    public var delegate: ThoughtFeedDelegate?
}

extension ThoughtFeedView {
    func setupView() {
        addSubview(thoughtCollectionView)
        addSubview(logo)
        addSubview(allThoughtsLabel)
        
        thoughtCollectionView.register(ThoughtFeedCellTile.self, forCellWithReuseIdentifier: ThoughtFeedCellTile.identifier)
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            delegate?.returnHome()
        }
    }
}
