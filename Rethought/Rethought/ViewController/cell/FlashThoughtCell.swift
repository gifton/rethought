//
//  QuickThoughtCell.swift
//  rethought
//
//  Created by Dev on 1/24/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class FlashThoughtCell: UICollectionViewCell {
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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.frame.size = CGSize(width: 50, height: 50)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    func setView() {
        addSubview(mainView)
        addSubview(title)
        title.setAnchor(top: mainView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 2, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
    }
    override func prepareForReuse() {
        self.title.addText(size: 9, font: .bodyLight, string: "")
    }
}
