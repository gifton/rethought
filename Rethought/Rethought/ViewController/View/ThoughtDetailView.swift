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
        self.backgroundColor = .white
        setupCell()
        styleCell()
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        addGestureRecognizer(edgePan)
    }
    
    convenience init(frame: CGRect, thought: Thought, delegate: DetailThoughtDelegate) {
        self.init(frame: frame)
        self.title = thought.title
        self.icon = thought.icon
        self.entries = thought.entries
        self.delegate = delegate
        addContext()
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
    //content recieved from thought
    private var title: String?
    private var icon: String?
    private var entries: [Entry]?
    //delegate for returning home, moving to new thought, editing etc
    public var delegate: DetailThoughtDelegate?
    
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
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            delegate?.returnHome()
        }
    }
}
