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
    
    convenience init(frame: CGRect, connector: DashboardDelegate) {
        self.init(frame: frame)
        self.connector = connector
    }
    
    var delegate: DashboardDelegate?
    
    //set custom identifier, set default identifier
    override var reuseIdentifier: String? {
        return "ThoughtFeedCellTile"
    }
    static var identifier: String {
        return "ThoughtFeedCellTile"
    }
    
    //dev object
    let randomTitles: [String] = ["Books", "Movies", "Keys", "reading", "Movie to watch", "backpack"]
    
    //conect to dashboard, hold recent thoughts for collectionView
    public var connector: DashboardDelegate?
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
        cv.layer.cornerRadius = 20
        
        return cv
    }()
    
    var searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "Search"), for: .normal)
        
        return btn
    }()
    
    let newFlashThought: UIButton = {
        let btn = UIButton()
        btn.frame.size = CGSize(width: 70, height: 70)
        btn.setImage(#imageLiteral(resourceName: "flash"), for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.backgroundColor = UIColor(hex: "51DF9F")
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 35
        
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
        newFlashThought.addTarget(self, action: #selector(setLarger(_:)), for: .touchUpInside)
        
        flashThoughtsCollectionView.frame = CGRect(x: 75, y: 65, width: ViewSize.SCREEN_WIDTH - 60, height: 70)
        
//        flashThoughtsCollectionView.setAnchor(top: reLogo.bottomAnchor, leading: leadingAnchor, bottom: searchButton.topAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 75, paddingBottom: 20, paddingTrailing: 0)
        
        newFlashThought.frame.origin = CGPoint(x: 0, y: 65)
        
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
        var inputs: [String] = []
        for _ in 0...2 {
            inputs += randomTitles
        }
        cell.title.addText(size: 9, font: .bodyLight, string: inputs[indexPath.row])
        return cell
    }
    
    @objc
    func setLarger(_ sender: Any) {
        if self.newFlashThought.frame.width > 100 {
            UIView.animate(withDuration: 0.65) {
                self.newFlashThought.frame = CGRect(x: 0, y: 50, width: ViewSize.SCREEN_WIDTH - 20, height: 250)
            }
        } else {
            UIView.animate(withDuration: 0.65) {
                self.newFlashThought.frame = CGRect(x: 0, y: 50, width: ViewSize.SCREEN_WIDTH - 20, height: 250)
            }
        }
        
//        self.connector?.userStartedNewFastThought()
    }
    
}
