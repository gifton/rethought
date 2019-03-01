//
//  RootView.swift
//  rethought
//
//  Created by Dev on 2/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RootView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "FAFAF6")
        
    }
    
    var model: RootViewModel! {
        didSet {
            setTableView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let recentThoughts: UITableView = {
        let tv = UITableView()
        tv.frame = ViewSize.FRAME
        tv.backgroundColor = UIColor(hex: "F7F5F0")
        tv.separatorStyle = .none
        return tv
    }()
        
    func setTableView() {
        recentThoughts.register(RootThoughtCell.self, forCellReuseIdentifier: RootThoughtCell.identifier)
        recentThoughts.register(RootEntriesContentCell.self, forCellReuseIdentifier: RootEntriesContentCell.identifier)
        recentThoughts.register(RootEntryViewCell.self, forCellReuseIdentifier: RootEntryViewCell.identifier)
        recentThoughts.delegate = model
        recentThoughts.dataSource = model
        addSubview(recentThoughts)
    }
    
    func setView() {
       
    }
}


