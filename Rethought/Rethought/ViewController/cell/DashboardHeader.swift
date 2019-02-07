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
        return "ThoughtFeedHeader"
    }
    static var identifier: String {
        return "ThoughtFeedHeader"
    }
    
    //dev object
    let randomTitles: [String] = ["March 14th", "April 11th", "January 22nd", "March 1st", "June 22nd", "May 21st"]
    
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
        layout.itemSize = CGSize(width: 196, height: 55)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    var searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "Search"), for: .normal)
        
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let rethoughtLogo: UILabel = {
        let lbl = UILabel()
        lbl.text = "Rethought"
        lbl.font = .reTitle(ofSize: 35)
        
        return lbl
    }()
}

extension DashboardHeader {
    func setViews() {
        
        //add to superView
        addSubview(allEntriesButton)
        addSubview(settingsButton)
        addSubview(rethoughtLogo)
        
        //style
        allEntriesButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 15, paddingTrailing: 20)
        
        settingsButton.frame = CGRect(x: ViewSize.SCREEN_WIDTH - 50, y: 12.5, width: 25, height: 25)
        settingsButton.setImage(#imageLiteral(resourceName: "cog"), for: .normal)
        
        rethoughtLogo.frame = CGRect(x: 20, y: 50, width: 180, height: 41)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LinkCell.identifier, for: indexPath) as! LinkCell
        var inputs: [String] = []
        for _ in 0...2 {
            inputs += randomTitles
        }
        cell.title.addText(size: 9, font: .bodyLight, string: inputs[indexPath.row])
        return cell
    }
    
}
