//
//  RootView.swift
//  rethought
//
//  Created by Dev on 2/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RootView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightBackground
        setCollectionView()
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let quickThoughtView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 74, height: 125)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(x: 10, y: 100, width: ViewSize.SCREEN_WIDTH - 10, height: 125), collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    let entryTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Entries"
        lbl.font = .boldSystemFont(ofSize: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    func setCollectionView() {
        quickThoughtView.register(LinkCell.self, forCellWithReuseIdentifier: LinkCell.identifier)
        quickThoughtView.delegate = self
        quickThoughtView.dataSource = self
        addSubview(quickThoughtView)
    }
    
    func setView() {
        addSubview(entryTitle)
        entryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        entryTitle.topAnchor.constraint(equalTo: quickThoughtView.bottomAnchor, constant: 25).isActive = true
        
    }
}

extension RootView: UICollectionViewDelegate {}
extension RootView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LinkCell.identifier, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
}
