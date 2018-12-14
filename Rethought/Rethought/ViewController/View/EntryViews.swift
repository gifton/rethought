//
//  EntryViews.swift
//  rethought
//
//  Created by Dev on 12/13/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryImageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        layoutCell()
    }
    
    convenience init(_ title: String, _ image: UIImage, _ date: String, frame: CGRect) {
        self.init(frame: frame)
        self.title.text = title
        self.date.text = date
        self.entryImage.image = image
    }
    
    var title: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 10, width: 330, height: 20))
        lbl.font = UIFont(name: "Lato-Bold", size: 16)
        
        return lbl
    }()
    var entryImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        img.image = UIImage.random(size: CGSize(width: 350, height: 125))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        return img
    }()
    var date: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Lato-Regular", size: 13)
        
        return lbl
    }()
    
    func layoutCell() {
        addSubview(title)
        addSubview(entryImage)
        
        entryImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        entryImage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true
        entryImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EntryTextView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        layoutCell()
    }
    
    convenience init(_ title: String, _ text: String, _ date: String, frame: CGRect) {
        self.init(frame: frame)
        self.title.text = title
        self.entryText.text = text
        self.date.text = date
    }
    
    var title: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 20, width: 330, height: 20))
        lbl.font = UIFont(name: "Lato-Bold", size: 16)
        
        return lbl
    }()
    var entryText: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 42, width: 340, height: 75))
        lbl.numberOfLines = 5
        lbl.font = UIFont(name: "Lato", size: 12)
        
        return lbl
    }()
    var date: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 300, y: 100, width: 50, height: 20))
        lbl.font = UIFont(name: "Lato-Black", size: 13)
        lbl.text = "2 days"
        
        return lbl
    }()
    
    func layoutCell() {
        addSubview(title)
        addSubview(entryText)
        addSubview(date)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
