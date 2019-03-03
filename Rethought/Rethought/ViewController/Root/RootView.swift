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
        backgroundColor = .white
        
    }
    
    var model: RootViewModel! {
        didSet {
            setTableView()
            print("model set")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let recentThoughts: UITableView = {
        let tv = UITableView()
        tv.frame = CGRect(x: 0, y: 110, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 150)
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
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


