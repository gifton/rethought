//
//  QuickThoughtCell.swift
//  rethought
//
//  Created by Dev on 1/24/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class LinkCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String {
        return "LinkCell"
    }
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "EFEFEF")
        view.frame.size = CGSize(width: 196, height: 40)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let linkImage: UIImageView = {
        let iv = UIImageView()
        iv.frame.size = CGSize(width: 25, height: 25)
        iv.image = #imageLiteral(resourceName: "linkImage")
        
        return iv
    }()
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    func setView() {
        addSubview(mainView)
        addSubview(title)
        
        title.setAnchor(top: mainView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 2, paddingLeading: 10, paddingBottom: 0, paddingTrailing: 0)
        
        mainView.addSubview(linkImage)
        linkImage.frame.origin = CGPoint(x: 7.5, y: 7.5)
    }
    
    //resetting
    override func prepareForReuse() {
        self.title.addText(size: 9, font: .bodyLight, string: "")
        
    }
}
