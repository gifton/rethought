//
//  ThoughtDetailTable.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailTable: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    public let tv: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = true
        tv.rowHeight = UITableView.automaticDimension
        tv.separatorInset = .zero
        tv.backgroundColor = .white
        
        return tv
    }()
    
    private func setView() {
        addSubview(tv)
        tv.setAnchor(top: safeTopAnchor, leading: safeLeadingAnchor, bottom: safeBottomAnchor, trailing: safeTrailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
