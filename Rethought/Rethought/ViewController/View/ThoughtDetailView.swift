//
//  ThoughtDetailView.swift
//  rethought
//
//  Created by Dev on 12/26/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//show individual thoughts in detail
class ThoughtDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, thought: Thought) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //init all objects
    private let topView = UIView(frame: CGRect(x: 0, y: 0, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT * 0.217))
    private let deleteButton = UIButton()
    private var iconLabel = UILabel()
    private var titleLabel = UILabel()
    private var recentEntriesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Recent Entries 💭"
        lbl.font = UIFont(name: "Lato-Bold", size: 18)
        lbl.frame.origin = CGPoint(x: 20, y: ViewSize.SCREEN_HEIGHT * 0.334)
        return lbl
    }()
    private var title: String?
    private var icon: String?
    private var 
    
    private let entryTV: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT * 0.369, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - (ViewSize.SCREEN_HEIGHT * 0.369)), style: UITableView.Style.plain)
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.estimatedRowHeight = 101
        return tv
    }()
}

extension ThoughtDetailView {
    func setupCell() {
        addSubview(topView)
        addSubview(iconLabel)
        addSubview(deleteButton)
        addSubview(titleLabel)
    }
    
    func styleCell() {
        
    }
    func addContext() {
        
    }
}
