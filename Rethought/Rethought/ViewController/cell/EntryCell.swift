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
        dateLabel.frame = CGRect(x: self.frame.size.width - 115, y: self.frame.size.height - 25, width: 120, height: 15)
        
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

class EntryTextCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public static var identifier: String { return "textCell" }
    
    //all objects
    private var titleLabel           = UILabel()
    private var bodyLabel            = UILabel()
    private var dateLabel            = UILabel()
    private var cellView             = UIView()
    
    //all variables
    private var title: String?
    private var body : String?
    private var date : String?
    
    func setView() {
        addSubview(bodyLabel)
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints  = false
        
        
        bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive     = true
        bodyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive            = true
        bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        bodyLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive        = true
        
        print(bodyLabel.frame)
    }
    
    var entry: Entry? {
        didSet {
            titleLabel.addText(size: 17, font: .title, string: entry!.title!)
            bodyLabel.addText(size: 12, font: .body, string: dummyBody)
            bodyLabel.numberOfLines = 0
            
            setView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dummyBody = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores"
    
//    private func styleCell() {
//
//        self.backgroundColor = UIColor(hex: "6271fc")
//        cell.layer.cornerRadius = 6
//        print("styling cell...")
//
//        title.numberOfLines = 0
//
//        title.font = UIFont.reTitle(ofSize: 15)
//        body.font = UIFont.reBody(ofSize: 15)
//        date.font = UIFont.reTitle(ofSize: 12)
//
//        title.textColor = .black
//        body.textColor = .black
//        date.textColor = .darkGray
//    }
}
