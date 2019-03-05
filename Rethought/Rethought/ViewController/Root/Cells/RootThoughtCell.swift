//
//  RootThoughtCell.swift
//  rethought
//
//  Created by Dev on 2/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RootThoughtCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildMain()
        buildView(); styleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String {
        return "RootThoughtsCell"
    }
    
    public func set(with thought: ThoughtPreview) {
        self.icon       = thought.icon.icon
        self.entryCount = thought.entryCount
        self.location   = String(describing: thought.location)
        self.date       = thought.createdAt
        self.title      = thought.title
    }
    
    // MARK: private variables
    private var icon: String!
    private var entryCount: EntryCount!
    private var location: String!
    private var date: Date!
    private var title: String!
    
    // MARK: Objects
    let main = UIView()
    let iconLabel           = UILabel()
    let titleLabel          = UILabel()
    let locationLabel       = UILabel()
    let textEntryCount      = UILabel()
    let imageEntryCount     = UILabel()
    let linkEntryCount      = UILabel()
    let recordingEntryLabel = UILabel()
    let dateLabel           = UILabel()
    
    private func buildMain() {
        main.frame = CGRect(x: 15, y: 7.5, width: ViewSize.SCREEN_WIDTH - 30, height: 200)
        addSubview(main)
        main.backgroundColor = UIColor(hex: "F9F9F9")
        main.layer.cornerRadius = 8
    }
    
    private func buildView() {
        main.addSubview(iconLabel)
        main.addSubview(titleLabel)
        
        iconLabel.frame = CGRect(x: 20, y: 20, width: 56, height: 56)
        titleLabel.frame = CGRect(x: 90, y: 20, width: ViewSize.SCREEN_WIDTH - 110, height: heightForView(text: "Should all gang members bang heavy heavy? or nah?", font: UIFont.boldSystemFont(ofSize: 20), width: ViewSize.SCREEN_WIDTH - 110))
        
    }
    
    private func styleView() {
        iconLabel.text = icon
        iconLabel.backgroundColor = .white
        iconLabel.textAlignment = .center
        iconLabel.layer.cornerRadius = 11
        iconLabel.layer.masksToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
    }
    
}
