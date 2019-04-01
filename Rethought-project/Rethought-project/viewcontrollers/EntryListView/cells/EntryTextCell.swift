//
//  EntryListTextCell.swift
//  Rethought-project
//
//  Created by Dev on 3/20/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryTextCell: UITableViewCell {
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
    private var title: String!
    
    //private objects
    private var thoughtIconLabel = UILabel()
    private var bodyLabel = UILabel()
    private var dateLabel = UILabel()
    private var locationLabel = UILabel()
    private var titleLabel = UILabel()
    
    func set(with context: TextEntryPreview) {
        thoughtIcon = context.thoughtIcon
        body = context.detail
        date = context.date
        location = "Seattle, washington"
        bodyLabelSize = context.size
        title = context.title
        addContext()
    }
    
    private func addContext() {
        thoughtIconLabel.text = thoughtIcon
        bodyLabel.text = body
        dateLabel.getStringFromDate(date: date)
        locationLabel.text = location
        titleLabel.text = title
        
        style()
    }
    
    private func style() {
        thoughtIconLabel.font = Device.font.mediumTitle(ofSize: .large)
        dateLabel.font = Device.font.mediumTitle(ofSize: .large)
        thoughtIconLabel.font = Device.font.mediumTitle(ofSize: .large)
        locationLabel.font = Device.font.mediumTitle(ofSize: .large)
        bodyLabel.font = Device.font.formalBodyText(ofSize: .medium)
        titleLabel.font = Device.font.title(ofSize: .xLarge)
        
        bodyLabel.numberOfLines = 0
        locationLabel.padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        locationLabel.addBorders(edges: [.left], color: .lightGray, thickness: 2)
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
        cell.addSubview(dateLabel)
        cell.addSubview(locationLabel)
        cell.addSubview(titleLabel)
        
        //place views
        thoughtIconLabel.frame = CGRect(x: 25, y: 10, width: 25, height: 25)
        dateLabel.frame = CGRect(x: 65, y: 10, width: 200, height: 25)
        locationLabel.frame = CGRect(x: 180, y: 10, width: 150, height: 25)
        titleLabel.frame = CGRect(x: 25, y: 40, width: cell.frame.width - 50, height: 35)
        bodyLabel.frame = CGRect(x: 25, y: (cell.frame.height - bodyLabelSize.height - 10), width: cell.frame.width - 50, height: bodyLabelSize.height)
        
    }
    
    private func buildTopStack() -> UIStackView {
        return UIStackView()
    }
    
    public static var identifier: String {
        return "EntryTextCell"
    }
}
