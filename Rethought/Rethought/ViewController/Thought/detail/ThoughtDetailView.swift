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
        styleView()
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        addGestureRecognizer(edgePan)
    }
    
    convenience init(frame: CGRect, thought: Thought, delegate: DetailThoughtDelegate) {
        self.init(frame: frame)
        self.title    = thought.title
        self.icon     = thought.icon
        self.entries  = thought.entries
        self.delegate = delegate
        addContext()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //init all objects
    private let topView                     = UIView(frame: CGRect(x: 0, y: 0, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT * 0.217))
    private let deleteButton                = UIButton()
    private var iconLabel                   = UILabel()
    private var titleLabel                  = UILabel()
    private let logo                        = UIImageView(image: #imageLiteral(resourceName: "Logo_with_bg"))
    private var recentEntriesLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: ViewSize.SCREEN_HEIGHT * 0.22, width: 300, height: 40))
        lbl.text = "Recent Entries 💭"
        lbl.textColor = .black
        lbl.font = .reBody(ofSize: 18)
        return lbl
    }()
    //content recieved from thought
    private var title:   String?
    private var icon:    String?
    public var entries:  [Entry]?
    //delegate for returning home, moving to new thought, editing etc
    public var delegate: DetailThoughtDelegate?
    
    let entryTV: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT * 0.269, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - (ViewSize.SCREEN_HEIGHT * 0.269)), style: UITableView.Style.plain)
        tv.allowsSelection = true
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 101
        return tv
    }()
}

extension ThoughtDetailView {
    func setupView() {
        addSubview(topView)
        addSubview(recentEntriesLabel)
        addSubview(entryTV)
        
        let views : [UIView] = [logo, deleteButton, iconLabel]
        var start = CGPoint(x: 25, y: 35)
        let spacingConstant: CGFloat = 70.0
        
        iconLabel.frame.size = CGSize(width: 30, height: 35)
        deleteButton.frame.size = CGSize(width: 30, height: 35)
        
        for innerView in views {
            topView.addSubview(innerView)
            innerView.frame.origin = start
            let newX = (spacingConstant + innerView.frame.width)
            start.x += newX
        }
        topView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    func styleView() {
        topView.backgroundColor = UIColor.init(hex: "161616")
        
        iconLabel.font = .reBody(ofSize: 28)
        
        deleteButton.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
        
        titleLabel.font = .reBody(ofSize: 18)
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .white
    }
    func addContext() {
        self.titleLabel.text = "What is to be done, nay to be said for the ill informed, advised and intentined portrayal of watermelon in modern film?"
        self.iconLabel.text = self.icon
        
        entryTV.delegate = self
        entryTV.dataSource = self
        entryTV.register(TextEntryCell.self, forCellReuseIdentifier: TextEntryCell.identifier)
        entryTV.register(ImageEntryCell.self, forCellReuseIdentifier: ImageEntryCell.identifier)
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            delegate?.returnHome()
        }
    }
}
