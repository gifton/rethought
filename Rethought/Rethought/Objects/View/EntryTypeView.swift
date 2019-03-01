//
//  EntryTypeView.swift
//  rethought
//
//  Created by Dev on 2/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryTypeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }
    
    let types = [EntryType.text, EntryType.image, EntryType.link, EntryType.recording]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        var views = [UIView]()
        for type in types {
            let lbl = buildLabel(type: type)
            views.append(lbl)
        }
        buildStack(views: views)
    }
    
    func buildStack(views: [UIView]) {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        stack.frame = frame
        stack.distribution = .equalSpacing
        
        addSubview(stack)
    }
    
    func buildLabel(type: EntryType) -> UILabel {
        let lbl = UILabel()
        lbl.text = type.rawValue.lowercased()
        lbl.font = UIFont.reBody(ofSize: 16)
        lbl.textColor = UIColor(hex: "876CBF")
        lbl.addBorders(edges: [.bottom])
        
        return lbl
    }
}
