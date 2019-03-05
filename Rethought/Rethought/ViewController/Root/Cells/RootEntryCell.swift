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
        quickThoughtView.register(RootEntryCell.self, forCellWithReuseIdentifier: RootEntryCell.identifier)
        quickThoughtView.delegate   = model
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
    
    func set(with entry: EntryPreview) {
        self.entryId = entry.id
        self.entryType = entry.type
        self.thoughtIcon = entry.thoughtIcon
        timeSince = String(describing: Date.timeIntervalSince(entry.date))
        buildView(); styleView()
    }
    
    // MARK: Variables
    public var entryId:      String!
    private var entryType:   EntryType!
    private var timeSince:   String!
    private var thoughtIcon: ThoughtIcon!
    
    // MARK: Objects
    private var entryTypeIcon = UIImageView()
    private var timeLabel = UILabel()
    private let thoughtIconView  = UILabel()
    
    func buildView() {
        
        switch entryType! {
        case .image:
            entryTypeIcon.image = #imageLiteral(resourceName: "camera-dark")
        case .text:
            entryTypeIcon.image = #imageLiteral(resourceName: "pen-square-dark")
        case .link:
            entryTypeIcon.image = #imageLiteral(resourceName: "link-dark")
        default:
            entryTypeIcon.image = #imageLiteral(resourceName: "microphone-dark")
        }
        
        timeLabel.text = timeSince
        thoughtIconView.text = thoughtIcon.icon
        
        addSubview(entryTypeIcon)
        addSubview(thoughtIconView)
        addSubview(timeLabel)
        
        entryTypeIcon.frame.size = CGSize(width: 28, height: 28)
        entryTypeIcon.frame.origin.y = 10
        entryTypeIcon.center.x = center.x
        
        thoughtIconView.frame.size = CGSize(width: 28, height: 28)
        thoughtIconView.center.x = center.x
        thoughtIconView.frame.origin.y = frame.size.height - 53
        
        timeLabel.frame = CGRect(x: 10, y: frame.height - 21, width: frame.width - 20, height: 16)
    }
    
    func styleView() {
        entryTypeIcon.backgroundColor = UIColor(hex: "F9F9F9")
        entryTypeIcon.layer.cornerRadius = 5
        thoughtIconView.layer.masksToBounds = true
        thoughtIconView.backgroundColor = UIColor(hex: "F9F9F9")
        thoughtIconView.layer.cornerRadius = 5
        entryTypeIcon.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String {
        return "LinkCell"
    }
    
    override func prepareForReuse() {
        self.entryTypeIcon.image = nil
        self.thoughtIconView.text = nil
        self.timeLabel.text = nil
    }
    
}
