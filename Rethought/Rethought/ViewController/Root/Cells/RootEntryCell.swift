//
//  QuickThoughtCell.swift
//  rethought
//
//  Created by Dev on 1/24/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


//RootEntryCell is a part of UITableView,
//and includes a collectionView insdie of that UITableView row

class RootEntryViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    public static var identifier: String {
        return "RootEntryViewCell"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let quickThoughtView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        layout.itemSize = CGSize(width: 74, height: 125)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: CGRect(x: 10, y: 10, width: ViewSize.SCREEN_WIDTH - 10, height: 125), collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    func setCollectionView(with model: RootViewModel) {
        quickThoughtView.register(EntryCell.self, forCellWithReuseIdentifier: EntryCell.identifier)
        quickThoughtView.delegate = model
        quickThoughtView.dataSource = model
        addSubview(quickThoughtView)
    }

}

class RootEntryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.frame.origin.y = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String {
        return "LinkCell"
    }
    
}
