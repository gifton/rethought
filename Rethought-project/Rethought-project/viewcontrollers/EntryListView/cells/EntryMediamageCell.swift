//
//  EntryImageCell.swift
//  Rethought-project
//
//  Created by Dev on 3/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//image cell
class EntryMediaCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    //objects
    private var mainImage  = UIImageView()
    private var titleLabel = UILabel()
    private var dateLabel  = UILabel()
    
    //variables
    private var entryImg   : UIImage = UIImage(color: Device.colors.mainBlue)!
    private var entryTitle : String = ""
    private var entryDate  : Date = Date()
    
    //send info to cell
    func giveContext(with entry: MediaEntryPreview) {
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
        mainImage.frame               = CGRect(x: 15, y: 0, width: self.frame.width - 30, height: entryImg.size.height)
        mainImage.layer.masksToBounds = true
        
        titleLabel.text = entryTitle
        dateLabel.getStringFromDate(date: entryDate)
        
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
