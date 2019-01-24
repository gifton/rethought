//
//  QuickThoughtCell.swift
//  rethought
//
//  Created by Dev on 1/24/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class QuickThoughtCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String {
        return "TextEntryPreview"
    }
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .random
        
        view.frame.size = CGSize(width: 50, height: 50)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.addText(size: 13, font: .bodyLight, string: "Books")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    func setView() {
        addSubview(mainView)
        addSubview(title)
        title.setAnchor(top: mainView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 2, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
    }
    
}
