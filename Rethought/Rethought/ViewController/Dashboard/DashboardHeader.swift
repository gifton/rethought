//
//  DashboardHeader.swift
//  rethought
//
//  Created by Dev on 1/22/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DashboardHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setViews()
    }
    override var reuseIdentifier: String? {
        return "ThoughtFeedCellTile"
    }
    static var identifier: String {
        return "ThoughtFeedCellTile"
    }
    public var delegate: DashboardDelegate?
    public var recentEntries: [ReccomendedThought] = []
    
    let allEntriesButton: UIButton = {
        let btn = UIButton()
        btn.addAttText(color: UIColor(hex: "D63864"), size: 13, font: .title, string: "All entries")
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let reLogo = UIImageView(image: #imageLiteral(resourceName: "Logo"))
    
    var recentEntriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = ViewSize.thoughtCellSmall
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    var searcher: UISearchBar = {
        let sb = UISearchBar()
        sb.barStyle = .default
        sb.returnKeyType = .search
        
        return sb
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DashboardHeader {
    func setViews() {
        addSubview(allEntriesButton)
        addSubview(searcher)
        addSubview(reLogo)
        addSubview(recentEntriesCollectionView)
        allEntriesButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 12.5, paddingTrailing: 20)
        
        searcher.frame.origin = CGPoint(x: 0, y: self.frame.height - 45)
        searcher.frame.size = CGSize(width: ViewSize.SCREEN_WIDTH - 110, height: 40)
        searcher.backgroundImage = UIImage()
        
        reLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            reLogo.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10),
            
        ])
        
        recentEntriesCollectionView.register(RecentEntryCell.self, forCellWithReuseIdentifier: RecentEntryCell.identifier)
        recentEntriesCollectionView.delegate = self
        recentEntriesCollectionView.dataSource = self
        
        recentEntriesCollectionView.setAnchor(top: reLogo.bottomAnchor, leading: leadingAnchor, bottom: searcher.topAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 0, paddingBottom: 5, paddingTrailing: 0)
    }
}
extension DashboardHeader: UISearchBarDelegate {
    
}


extension DashboardHeader: UICollectionViewDelegate {
    
}

extension DashboardHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentEntryCell.identifier, for: indexPath) as! RecentEntryCell
        cell.giveContext(recentEntries[indexPath.row])

        return cell
    }
    
    
}

