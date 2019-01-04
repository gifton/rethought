////
////  ReccomendedThoughtCell.swift
////  rethought
////
////  Created by Dev on 12/9/18.
////  Copyright © 2018 Wesaturate. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class RecentThoughtCell: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupCell()
//    }
//    
//    var title: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "add new"
//        lbl.font = .reBodyLight(ofSize: 10)
//        lbl.textColor = .darkText
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.textAlignment = .center
//        lbl.adjustsFontSizeToFitWidth = true
//
//        return lbl
//    }()
//    let icon: UIView = {
//        let iv = UIView()
//        iv.backgroundColor = UIColor(hex: "FBF6EB")
//        iv.layer.cornerRadius = 4
//
//        return iv
//    }()
//
//    var emoji: UILabel = {
//        let lbl = UILabel()
//        lbl.backgroundColor = .clear
//        lbl.font = .boldSystemFont(ofSize: 35)
//        lbl.text = "⚽️"
//        return lbl
//    }()
//
//    public func giveContext() {
//
//    }
//
//    private func setupCell() {
//
//
//        self.contentView.addSubview(icon)
//        self.contentView.addSubview(title)
//        icon.frame.size = CGSize(width: 56, height: 56)
//        icon.center = self.center
//        icon.center.y -= 25
//
//        title.setAnchor(top: icon.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 2, paddingLeading: 2, paddingBottom: 2, paddingTrailing: 2)
//        icon.addSubview(emoji)
//        emoji.frame = icon.frame
//        emoji.center.y += 2
//        emoji.center.x -= 4
//
//
//    }
//
//    override func prepareForReuse() {
//        self.title.text = nil
//    }
//
//    override func prepareForInterfaceBuilder() {
//        self.title.text = nil
//    }
//
//
//    public static var identifier: String {
//        return "RecentThoughtCell"
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
