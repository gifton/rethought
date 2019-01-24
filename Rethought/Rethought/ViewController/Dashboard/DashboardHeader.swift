//
//  DashboardHeader.swift
//  rethought
//
//  Created by Dev on 1/22/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//CollectionView header
class DashboardHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setViews()
    }
    
    //set custom identifier, set default identifier
    override var reuseIdentifier: String? {
        return "ThoughtFeedCellTile"
    }
    static var identifier: String {
        return "ThoughtFeedCellTile"
    }
    
    //conect to dashboard, hold recent thoughts for collectionView
    public var delegate: DashboardDelegate?
    public var recentEntries: [ReccomendedThought] = []
    
    let allEntriesButton: UIButton = {
        let btn = UIButton()
        btn.addAttText(color: UIColor(hex: "D63864"), size: 13, font: .title, string: "All entries")
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let reLogo = UIImageView(image: #imageLiteral(resourceName: "Logo"))
    
    var reccomendedThoughtsCollectionView: UICollectionView = {
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
        
        //add to superView
        addSubview(allEntriesButton)
        addSubview(searcher)
        addSubview(reLogo)
        addSubview(reccomendedThoughtsCollectionView)
        
        //sty;e
        allEntriesButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 12.5, paddingTrailing: 20)
        
        searcher.frame.origin = CGPoint(x: 0, y: self.frame.height - 45)
        searcher.frame.size = CGSize(width: ViewSize.SCREEN_WIDTH - 110, height: 40)
        searcher.backgroundImage = UIImage()
        
        reLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            reLogo.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10),
            
        ])
        
        reccomendedThoughtsCollectionView.register(ReccomendedThoughtCellMicro.self, forCellWithReuseIdentifier: ReccomendedThoughtCellMicro.identifier)
        reccomendedThoughtsCollectionView.delegate = self
        reccomendedThoughtsCollectionView.dataSource = self
        
        reccomendedThoughtsCollectionView.setAnchor(top: reLogo.bottomAnchor, leading: leadingAnchor, bottom: searcher.topAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 0, paddingBottom: 5, paddingTrailing: 0)
    }
}
extension DashboardHeader: UISearchBarDelegate {
    
}


extension DashboardHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected thought \(recentEntries[indexPath.row].icon.icon)")
    }
}

extension DashboardHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentEntries.count
    }
    
    //set cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReccomendedThoughtCellMicro.identifier, for: indexPath) as! ReccomendedThoughtCellMicro
        cell.giveContext(recentEntries[indexPath.row])

        return cell
    }
    
    
}

