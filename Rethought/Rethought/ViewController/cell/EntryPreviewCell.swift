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
    public func giveContext(with preview: EntryPreview) {
        self.title.text = preview.title
        self.date.text = String(describing: preview.date)
        self.body.text = preview.description
        self.body.numberOfLines = 5
        self.parentThought.text = preview.ThoughtID
        
    }
    public func giveContext(with entry: Entry) {
        self.title.text = entry.title
        self.date.text = String(describing: entry.date)
        self.body.text = entry.description
        self.body.numberOfLines = 5
        self.parentThought.text = entry.thoughtID
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


//image cell
class ImageEntryCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var mainImage       = UIImageView()
    private var parentThought   = UILabel()
    private var date            = UILabel()
    private var imageCount      = UILabel(frame: CGRect(x: 15, y: 15, width: 65, height: 25))
    
    public static var identifier: String {
        return "ImageEntryPreview"
    }
    
    public func giveContext(with preview: EntryPreview) {
        self.date.text = String(describing: preview.date)
        self.mainImage.image = preview.images.first
        self.parentThought.text = preview.ThoughtID
        self.imageCount.text = String(describing: preview.imageCount!) + " images"
        guard let height = mainImage.image?.size.height else { return }
        self.mainImage.frame = CGRect(x: 0, y: 0, width: ViewSize.SCREEN_WIDTH, height: height - 20)
        buildCell()
        styleCell(mainImage.frame)
    }
    public func giveContext(with entry: Entry) {
        self.date.text = String(describing: entry.date)
        self.mainImage.image = entry.images.first
        self.parentThought.text = entry.thoughtID
        self.imageCount.text = String(describing: entry.images.count) + " images"
        guard let height = mainImage.image?.size.height else { return }
        self.mainImage.frame = CGRect(x: 0, y: 0, width: ViewSize.SCREEN_WIDTH, height: height - 20)
        buildCell()
        styleCell(mainImage.frame)
    }
    
    private func buildCell() {
        let items = [mainImage, parentThought, date, imageCount]
        for item in items {
            addSubview(item)
        }
        
    }
    
    private func styleCell(_ size: CGRect) {
        let labels = [parentThought, date, imageCount]
        addSubview(mainImage)
        for label in labels {
            addSubview(label)
            if label == imageCount {
                label.font = UIFont.reBody(ofSize: 15)
                label.textColor = .black
            } else {
                label.font = UIFont.reBodyLight(ofSize: 12)
                label.textColor = .darkGray
            }
            label.backgroundColor = .white
            label.layer.cornerRadius = 5
            label.textAlignment = .center
            
            label.layer.opacity = 0.9
            label.layer.masksToBounds = true
        }
        parentThought.frame = CGRect(x: 15, y: size.height - 40, width: 150, height: 25)
        date.frame = CGRect(x: size.width - 100, y: size.height - 40, width: 100, height: 25)
    }
}
