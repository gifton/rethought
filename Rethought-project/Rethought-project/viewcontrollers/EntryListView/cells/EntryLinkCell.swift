//
//  EntryLinkCell.swift
//  Rethought-project
//
//  Created by Dev on 3/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


//link cell
class EntryLinkCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    private var linkImage : UIImage?
    private var detail    : String!
    private var linkDate  : Date!
    private var linkTitle : String!
    
    private var linkIV      = UIImageView()
    private var detailLabel = UILabel()
    private var datelabel   = UILabel()
    private var titleLabel  = UILabel()
    
    public static var identifier: String { return "linkCell" }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with preview: LinkEntryPreview) {
        linkImage = preview.image
        linkTitle = preview.title
        detail = preview.linkDescription
        linkDate = preview.date
        buildCell()
    }
    
    func buildCell() {
        let cell = UIView()
        cell.frame = CGRect(x: 15, y: 0, width: Device.size.width - 30, height: 75)
        cell.backgroundColor = Device.colors.lightClay
        cell.layer.cornerRadius = 6
        addSubview(cell)
        
        linkIV.image = linkImage
        linkIV.layer.cornerRadius = 5
        linkIV.layer.masksToBounds = true
        linkIV.frame = CGRect(x: 20, y: 15, width: 45, height: 45)
        
        titleLabel.font = Device.font.mediumTitle(ofSize: .large)
        titleLabel.frame = CGRect(x: 80, y: 12, width: 185, height: 20)
        
        detailLabel.font = Device.font.body(ofSize: .small)
        detailLabel.textColor = UIColor(hex: "4A4A4A")
        detailLabel.numberOfLines = 2
        detailLabel.frame = CGRect(x: 80, y: 32, width: 185, height: 28)
        
        datelabel.getStringFromDate(date: linkDate)
        datelabel.frame = CGRect(x: cell.frame.width - 100, y: cell.frame.height - 22, width: 88, height: 12)
        
        cell.addSubview(linkIV)
        cell.addSubview(titleLabel)
        cell.addSubview(detailLabel)
        cell.addSubview(datelabel)
    }
    
}

