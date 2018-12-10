//
//  ReccomendedThoughtCell.swift
//  rethought
//
//  Created by Dev on 12/9/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RecentThoughtCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "add new"
        lbl.font = UIFont(name: "Lato-Light", size: 10)
        lbl.textColor = .darkText
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        
        return lbl
    }()
    
    private func setupCell() {
        let icon: UIView = {
            let iv = UIView()
            iv.backgroundColor = UIColor(hex: "FBF6EB")
            iv.layer.cornerRadius = 4
            
            return iv
        }()
        
        self.contentView.addSubview(icon)
        self.contentView.addSubview(title)
        icon.frame.size = CGSize(width: 56, height: 56)
        icon.center = self.center
        icon.center.y -= 25
        
        title.setAnchor(top: icon.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 2, paddingLeading: 2, paddingBottom: 2, paddingTrailing: 2)
        
    }
    
    override func prepareForReuse() {
        self.title.text = nil
    }
    
    
    public static var identifier: String {
        return "RecentThoughtCell"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
