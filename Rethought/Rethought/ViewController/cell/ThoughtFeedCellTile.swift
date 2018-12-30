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
        self.backgroundColor = .mainBlue
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
    var titleLabel          = UILabel(frame: CGRect(x: 8, y: 8, width: 134, height: 34))
    var iconLabel           = UILabel(frame: CGRect(x: 59, y: 45, width: 42, height: 42))
    private var linkLabel   = UILabel()
    private var entryLabel  = UILabel()
    private var mediaLabel  = UILabel()
    private let dayCountLabel = UILabel(frame: CGRect(x: 60, y: 122, width: 100, height: 20))
    
    public func giveContext(with preview: ThoughtPreviewLarge) {
        self.icon = preview.icon
        self.title = preview.title
        self.entryCount = preview.entryCount["entries"]
        self.linkCount = preview.entryCount["links"]
        self.mediaCount = preview.entryCount["media"]
        self.dayCount = 232
        recievedContext()
    }
    
    private func setupCell() {
        let lbls = [linkLabel, entryLabel, mediaLabel]
        let stack = UIStackView(arrangedSubviews: lbls)
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.frame = CGRect(x: 10, y: 85, width: 70, height: 55)
        addSubview(stack)
        addSubview(titleLabel)
        addSubview(iconLabel)
        addSubview(dayCountLabel)
    }
    
    private func styleCell() {
        self.layer.cornerRadius = 10
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = .reBody(ofSize: 14)
        iconLabel.font = .reBody(ofSize: 32)
        let lbls = [linkLabel, entryLabel, mediaLabel]
        for lbl in lbls {
            lbl.font = .reBodyLight(ofSize: 12)
            lbl.textColor = UIColor(hex: "5D5D5D")
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
