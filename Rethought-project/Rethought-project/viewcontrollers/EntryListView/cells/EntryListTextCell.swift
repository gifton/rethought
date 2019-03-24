//
//  EntryListTextCell.swift
//  Rethought-project
//
//  Created by Dev on 3/20/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryListTextCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //private variables
    private var thoughtIcon: String!
    private var body: String!
    private var date: String!
    private var location: String!
    
    //private objects
    private var thoughtIconLabel = UILabel()
    private var bodyLabel = UILabel()
    private var dateLabel = UILabel()
    private var locationLabel = UILabel()
    
    func set(with context: TextEntryPreview) {
        thoughtIcon = context.title
        body = context.detail
        date = "\(context.date)"
        location = "Seattle, washington"
        addContext()
    }
    
    private func addContext() {
        thoughtIconLabel.text = thoughtIcon
        bodyLabel.text = body
        dateLabel.text = date
        locationLabel.text = location
        style()
    }
    
    private func style() {
        thoughtIconLabel.font = Device.font.mediumTitle(ofSize: .large)
        dateLabel.font = Device.font.mediumTitle(ofSize: .large)
        thoughtIconLabel.font = Device.font.mediumTitle(ofSize: .large)
        locationLabel.font = Device.font.mediumTitle(ofSize: .large)
        buildView()
    }
    
    private func buildView() {
        
        //add to superview
        addSubview(thoughtIconLabel)
        addSubview(bodyLabel)
//        addSubview(dateLabel)
//        addSubview(locationLabel)
        
        //place views
        thoughtIconLabel.frame = CGRect(x: 25, y: 10, width: 25, height: 25)
        bodyLabel.frame = CGRect(x: 25, y: 50, width: frame.width - 50, height: frame.height - 70)
    }
    
    private func buildTopStack() -> UIStackView {
        return UIStackView()
    }
    
    public static var identifier: String {
        return "EntryListTextCell"
    }
}
