//
//  EntryPreviewCell.swift
//  rethought
//
//  Created by Dev on 12/13/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//theres 2 types of cells right now: Text, and image.

//image cell
class EntryImageCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    //objects
    private var mainImage  = UIImageView()
    private var titleLabel = UILabel()
    private var dateLabel  = UILabel()
    
    //variables
    private var entryImg   : UIImage?
    private var entryTitle : String?
    private var entryDate  : Date?
    
    //send info to cell
    func giveContext(with entry: Entry) {
        self.entryImg   = entry.image
        self.entryTitle = entry.detail
        self.entryDate  = entry.date
        setView()
    }
    
    //buildCell
    func setView() {
        mainImage.image               = entryImg
        mainImage.contentMode         = .scaleAspectFill
        mainImage.layer.cornerRadius  = 6
        mainImage.frame               = CGRect(x: 15, y: 0, width: self.frame.width - 30, height: (entryImg?.size.height)!)
        mainImage.layer.masksToBounds = true
        
        titleLabel.addText(size: 12, font: .bodyLight, string: entryTitle ?? "💭")
        dateLabel.getStringFromDate(date: entryDate ?? Date())
        
        titleLabel.frame = CGRect(x: 20, y: self.frame.size.height - 25, width: 250, height: 15)
        dateLabel.frame = CGRect(x: self.frame.size.width - 95, y: self.frame.size.height - 25, width: 120, height: 15)
        
        print(self.mainImage.frame)
        addSubview(mainImage)
        addSubview(titleLabel)
        addSubview(dateLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public static var identifier: String {
        return "imageCell"
    }
}


//Text Cell
class EntryTextCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public static var identifier: String { return "textCell" }
    
    //all objects
    public var titleLabel  = UILabel()
    private var bodyLabel   = UILabel()
    private var dateLabel   = UILabel()
    private var cellView    = UIView()
    private var titleCircle = UIView()
    //all variables
    private var title: String?
    private var body : String?
    private var date : String?
    
    func setView() {
        titleCircle.frame = CGRect(x: 15, y: 12.5, width: 8, height: 8)
        titleCircle.layer.cornerRadius = 4
        titleCircle.backgroundColor = UIColor(hex: "161616")
        
        let cell = UIView()
        cell.frame = CGRect(x: 15, y: 0, width: ViewSize.SCREEN_WIDTH - 30, height: 80)
        cell.backgroundColor = UIColor(hex: "F5F5F9")
        cell.layer.cornerRadius = 6
        addSubview(cell)
        
        cell.addSubview(titleLabel)
        cell.addSubview(titleCircle)
        cell.addSubview(bodyLabel)
        cell.addSubview(dateLabel)
        
        titleLabel.frame = CGRect(x: 32, y: 5, width: cell.frame.width - 132, height: 20)
        bodyLabel.frame = CGRect(x: 15, y: 30, width: cell.frame.width - 30, height: 45)
        dateLabel.frame = CGRect(x: cell.frame.width - 95, y: 7.5, width: 70, height: 15)
    }
    
    var entry: Entry! {
        didSet {
            titleLabel.addText(size: 17, font: .title, string: entry.title!)
            bodyLabel.addText(size: 12, font: .body, string: dummyBody)
            bodyLabel.textColor = UIColor(hex: "4A4A4A")
            bodyLabel.numberOfLines = 3
            dateLabel.getStringFromDate(date: entry.date)
            setView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dummyBody = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta que laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam vasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores"
}

class EntryLinkCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    private var linkImage : UIImage!
    private var detail    : String!
    private var linkDate      : Date!
    private var linkTitle : String!
    
    private var linkIV      = UIImageView()
    private var detailLabel = UILabel()
    private var datelabel   = UILabel()
    private var titleLabel  = UILabel()
    
    public static var identifier: String { return "linkCell" }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var entry: Entry! {
        didSet {
            self.linkImage = entry.linkImage!
            self.linkTitle = entry.linkTitle
            self.detail = entry.detail
            self.linkDate = entry.date
            buildCell()
        }
    }
    
    func buildCell() {
        let cell = UIView()
        cell.frame = CGRect(x: 15, y: 0, width: ViewSize.SCREEN_WIDTH - 30, height: 75)
        cell.backgroundColor = UIColor(hex: "F5F5F9")
        cell.layer.cornerRadius = 6
        addSubview(cell)
        
        linkIV.image = linkImage
        linkIV.layer.cornerRadius = 5
        linkIV.layer.masksToBounds = true
        linkIV.frame = CGRect(x: 20, y: 15, width: 45, height: 45)
        
        titleLabel.addText(size: 17, font: .title, string: linkTitle)
        titleLabel.frame = CGRect(x: 80, y: 12, width: 185, height: 20)
        
        detailLabel.addText(size: 12, font: .body, string: detail)
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
