//
//  ThoughtFeedCellTile.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtFeedCellTile: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.10)
        setupCell()
        styleCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //vars
    static var identifier:     String {
        return "ThoughtFeedCellTile"
    }
    private var icon:          String?
    private var title:         String?
    private var entryCount:    Int?
    private var linkCount:     Int?
    private var mediaCount:    Int?
    private var dayCount:      Int?
    
    //objs
    var titleLabel            = UILabel()
    var iconLabel             = UILabel()
    private var linkLabel     = UILabel()
    private var entryLabel    = UILabel()
    private var mediaLabel    = UILabel()
    private let dayCountLabel = UILabel()
    
    public func giveContext(with preview: ThoughtPreview) {
        self.icon       = preview.icon
        self.title      = preview.title
        self.entryCount = preview.entryCount["entries"]
        self.linkCount  = preview.entryCount["links"]
        self.mediaCount = preview.entryCount["media"]
        self.dayCount   = 232
        recievedContext()
    }
    
    public func giveContext(with dashboardThought: DashboardThought) {
        self.icon       = dashboardThought.icon
        self.title      = dashboardThought.title
        self.entryCount = dashboardThought.entryCount["entries"]
        self.linkCount  = dashboardThought.entryCount["links"]
        self.mediaCount = dashboardThought.entryCount["media"]
        self.dayCount   = 232
        recievedContext()
    }
    
    private func setupCell() {
        let lbls = [linkLabel, entryLabel, mediaLabel]
        let stack = UIStackView(arrangedSubviews: lbls)
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.frame = CGRect(x: 15, y: self.frame.height - 75, width: 70, height: 55)
        
        titleLabel.frame = CGRect(x: 15, y: 8, width: self.frame.width - 30, height: 55)
        iconLabel.center = CGPoint(x: (self.frame.width - 21) / 2, y: (self.frame.height - 21) / 2)
        iconLabel.frame.size = CGSize(width: 42, height: 42)
        dayCountLabel.frame = CGRect(x: 100, y: self.frame.height - 35, width: 100, height: 15)
        dayCountLabel.layer.borderColor = UIColor.white.cgColor
        
        addSubview(stack)
        addSubview(titleLabel)
        addSubview(iconLabel)
        addSubview(dayCountLabel)
    }
    
    private func styleCell() {
        self.layer.cornerRadius = 4
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = .reBody(ofSize: 14)
        iconLabel.font = .reBody(ofSize: 32)
        let lbls = [linkLabel, entryLabel, mediaLabel]
        for lbl in lbls {
            lbl.font = .reBodyLight(ofSize: 12)
            lbl.textColor = .white
        }
        dayCountLabel.font = .reTitle(ofSize: 12)
        dayCountLabel.textAlignment = .center
    }
    
    private func recievedContext() {//check for all variables
        guard let title       = self.title else { return }
        guard let icon        = self.icon else { return }
        guard let linkCount   = self.linkCount else { return }
        guard let entryCount  = self.entryCount else { return }
        guard let mediaCount  = self.mediaCount else { return }
        guard let dayCount    = self.dayCount else { return }
        
        self.titleLabel.text = title
        self.iconLabel.text = icon
        self.linkLabel.text = String(describing: linkCount) + " Links"
        self.entryLabel.text = String(describing: entryCount) + " Entries"
        self.mediaLabel.text = String(describing: mediaCount) + " media"
        self.dayCountLabel.text = String(describing: dayCount) + " days"
    }
}
