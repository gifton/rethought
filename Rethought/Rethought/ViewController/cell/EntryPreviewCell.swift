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
class TextEntryCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    //all object init's
    private var title           = UILabel(frame: CGRect(x: 5, y: 0, width: ViewSize.SCREEN_WIDTH - 20, height: 20))
    private var body            = UILabel(frame: CGRect(x: 5, y: 15, width: ViewSize.SCREEN_WIDTH - 20, height: 60))
    private var parentThought   = UILabel(frame: CGRect(x: 5, y: 70, width: 100, height: 20))
    private var date            = UILabel(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 100, y: 75, width: 100, height: 10))
    
    //cellIdentifier
    public static var identifier: String {
        return "TextEntryPreview"
    }
    
    // "give context" is called during the cewllForRow: function in delegate
    public func giveContext(_ content: EntryPreview) {
        self.title.text = content.title
        self.date.text = String(describing: content.date)
        self.body.text = content.description
        self.body.numberOfLines = 5
        self.parentThought.text = content.ThoughtID
        
    }
    
    private func styleCell() {
        addSubview(title)
        addSubview(body)
        addSubview(parentThought)
        addSubview(date)
        
        title.font = UIFont.retitle(ofSize: 15)
        body.font = UIFont.reBody(ofSize: 15)
        parentThought.font = UIFont.reBodyLight(ofSize: 12)
        date.font = UIFont.reBodyLight(ofSize: 12)
        
        title.textColor = .black
        body.textColor = .black
        parentThought.textColor = .darkGray
        date.textColor = .darkGray
    }
}



class ImageEntryCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var mainImage       = UIImageView()
    private var parentThought   = UILabel(frame: CGRect(x: 5, y: 80, width: 100, height: 20))
    private var date            = UILabel(frame: CGRect(x: 5, y: 90, width: 100, height: 10))
    private var imageCount      = UILabel(frame: CGRect(x: 15, y: 15, width: 85, height: 40))
    
    public static var identifier: String {
        return "ImageEntryPreview"
    }
    
    public func giveContext(_ content: EntryPreview) {
        self.date.text = String(describing: content.date)
        self.mainImage.image = content.images.first
        self.parentThought.text = content.ThoughtID
        self.imageCount.blurBackground(type: .light, cornerRadius: 5)
        self.imageCount.text = String(describing: content.imageCount!)
        let height = mainImage.image?.size.height
        self.mainImage.frame = CGRect(x: 0, y: 0, width: ViewSize.SCREEN_WIDTH, height: height! - 20)
        styleCell()
    }
    
    private func styleCell() {
        addSubview(mainImage)
        addSubview(parentThought)
        addSubview(date)
        addSubview(imageCount)
        
        imageCount.font = UIFont.reBody(ofSize: 15)
        parentThought.font = UIFont.reBodyLight(ofSize: 12)
        date.font = UIFont.reBodyLight(ofSize: 12)
        
        imageCount.textColor = .black
        parentThought.textColor = .darkGray
        date.textColor = .darkGray
    }
}
