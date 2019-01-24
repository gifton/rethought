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
        btn.addAttText(color: UIColor(hex: "D63864"), size: 13, font: .title, string: "All quick Thoughts")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let reLogo = UIImageView(image: #imageLiteral(resourceName: "Logo"))
    let settingsButton = UIButton()
    
    var flashThoughtsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = ViewSize.thoughtCellSmall
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.cornerRadius = 9
        
        return cv
    }()
    
    var searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "Search"), for: .normal)
        
        return btn
    }()
    
    let newFlashThought: UIButton = {
        let btn = UIButton()
        btn.setHeightWidth(width: 60, height: 60)
        btn.setImage(#imageLiteral(resourceName: "flash"), for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 30
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DashboardHeader {
    func setViews() {
        
        //add to superView
        addSubview(allEntriesButton)
        addSubview(searchButton)
        addSubview(reLogo)
        addSubview(flashThoughtsCollectionView)
        addSubview(newFlashThought)
        addSubview(settingsButton)
        
        //style
        allEntriesButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 25, paddingTrailing: 20)
        
        searchButton.frame.origin = CGPoint(x: 10, y: self.frame.height - 45)
        searchButton.frame.size = CGSize(width: 20, height: 20)
        
        reLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            reLogo.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10),
        ])
        
        flashThoughtsCollectionView.register(FlashThoughtCell.self, forCellWithReuseIdentifier: FlashThoughtCell.identifier)
        flashThoughtsCollectionView.delegate = self
        flashThoughtsCollectionView.dataSource = self
        
        flashThoughtsCollectionView.setAnchor(top: reLogo.bottomAnchor, leading: leadingAnchor, bottom: searchButton.topAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 80, paddingBottom: 20, paddingTrailing: 0)
        
        NSLayoutConstraint.activate([
            newFlashThought.centerYAnchor.constraint(equalTo: flashThoughtsCollectionView.centerYAnchor),
            newFlashThought.trailingAnchor.constraint(equalTo: flashThoughtsCollectionView.leadingAnchor, constant: -10),
        ])
        
        settingsButton.frame = CGRect(x: ViewSize.SCREEN_WIDTH - 50, y: 12.5, width: 25, height: 25)
        settingsButton.setImage(#imageLiteral(resourceName: "cog"), for: .normal)
    }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashThoughtCell.identifier, for: indexPath) as! FlashThoughtCell
        

        return cell
    }
    
    
}

