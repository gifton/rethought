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
        build()
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
    
    private func build() {
        main.frame = CGRect(x: 15, y: 7.5, width: ViewSize.SCREEN_WIDTH - 30, height: 183)
        addSubview(main)
        main.backgroundColor = UIColor(hex: "F9F9F9")
        main.layer.cornerRadius = 8
    }
    
}
