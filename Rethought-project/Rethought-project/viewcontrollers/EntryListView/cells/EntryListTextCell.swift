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
    private var date: Date!
    private var location: String!
    private var bodyLabelSize: CGSize!
    
    //private objects
    private var thoughtIconLabel = UILabel()
    private var bodyLabel = UILabel()
    private var dateLabel = UILabel()
    private var locationLabel = UILabel()
    
    func set(with context: TextEntryPreview) {
        thoughtIcon = context.thoughtIcon
        body = context.detail
        date = context.date
        location = "Seattle, washington"
        bodyLabelSize = context.size
        addContext()
    }
    
    private func addContext() {
        thoughtIconLabel.text = thoughtIcon
        bodyLabel.text = body
        dateLabel.getStringFromDate(date: date)
        locationLabel.text = location
        
        style()
    }
    
    private func style() {
        thoughtIconLabel.font = Device.font.mediumTitle(ofSize: .large)
        dateLabel.font = Device.font.mediumTitle(ofSize: .large)
        thoughtIconLabel.font = Device.font.mediumTitle(ofSize: .large)
        locationLabel.font = Device.font.mediumTitle(ofSize: .large)
        bodyLabel.font = Device.font.body(ofSize: .medium)
        
        bodyLabel.numberOfLines = 0
        buildView()
    }
    
    private func buildView() {
        let cell = UIView(frame: CGRect(x: 10, y: 5, width: frame.width - 20, height: frame.height - 10))
        cell.backgroundColor = Device.colors.offWhite
        cell.layer.cornerRadius = 5
        //add to superview
        addSubview(cell)
        cell.addSubview(thoughtIconLabel)
        cell.addSubview(bodyLabel)
        addSubview(dateLabel)
        addSubview(locationLabel)
        
        //place views
        thoughtIconLabel.frame = CGRect(x: 15, y: 10, width: 25, height: 25)
        dateLabel.frame = CGRect(x: 50, y: 15, width: 150, height: 25)
        locationLabel.frame = CGRect(x: 200, y: 15, width: 150, height: 25)
        bodyLabel.frame = CGRect(x: 15, y: 45, width: bodyLabelSize.width, height: bodyLabelSize.height)
    }
    
    private func buildTopStack() -> UIStackView {
        return UIStackView()
    }
    
    public static var identifier: String {
        return "EntryListTextCell"
    }
}
