//
//  TopRootView.swift
//  Rethought-project
//
//  Created by Dev on 3/18/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RootHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViewStyle()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let searchBar = UISearchBar()
    let continueTheThoughtLabel = UILabel()
    public var entryCollection: EntryTypeCollection!
    
    public let thoughtCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Device.size.largeTile
        layout.minimumLineSpacing = 10
        
        let cv = UICollectionView(frame: CGRect(x: 20, y: 98, width: Device.size.width - 20, height: Device.size.largeTile.height), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    func setSearch() {
        addSubview(searchBar)
        searchBar.frame = CGRect(x: 20, y: 44, width: Device.size.width - 40, height: 39)
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = .search
        searchBar.searchBarStyle = .minimal
        
    }
    
    func setThoughtCollection() {
        thoughtCollection.register(TopRootThoughtCell.self, forCellWithReuseIdentifier: TopRootThoughtCell.identifier)
        addSubview(thoughtCollection)
        
    }
    
    func hide() {
        self.resignFirstResponder()
    }
    
    func setViewStyle() {
        backgroundColor = Device.colors.lightClay
//        roundCorners([.bottomLeft, .bottomRight], radius: 30)
        setSearch(); setThoughtCollection(); setContinueTheThoughtLabel(); setEntryCollection()
    }
    
    func setContinueTheThoughtLabel() {
        addSubview(continueTheThoughtLabel)
        continueTheThoughtLabel.frame = CGRect(x: 20, y: 275, width: 200, height: 20)
        
        continueTheThoughtLabel.font = Device.font.mediumTitle(ofSize: Device.fontSize.large)
        continueTheThoughtLabel.textColor = .darkGray
        continueTheThoughtLabel.text = "🚂 continue the thought"
    }
    
    func setEntryCollection() {
        entryCollection = EntryTypeCollection(frame: CGRect(x: 20, y: 325, width: Device.size.width - 40, height: 40))
        addSubview(entryCollection)
    }
}
