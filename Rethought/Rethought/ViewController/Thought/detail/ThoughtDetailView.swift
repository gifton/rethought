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
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        addGestureRecognizer(edgePan)
    }
    
    convenience init(frame: CGRect, thought: Thought, delegate: ThoughtDetailDelegagte) {
        self.init(frame: frame)
        self.title    = thought.title
        self.icon     = thought.icon
        self.entries  = thought.entries
        self.delegate = delegate
        self.counts = thought.entryCount
        addContext()
        styleView()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //init all objects
    private let topView                     = UIView()
    private let deleteButton                = UIButton()
    private var iconLabel                   = UILabel()
    private var titleLabel                  = UITextView()
    private let logo                        = UIImageView(image: #imageLiteral(resourceName: "Logo_with_bg"))
    
    //content recieved from thought
    private var title:   String?
    private var icon:    String?
    public var entries:  [Entry]?
    private var counts: [String: Int]?
    
    //delegate for returning home, moving to new thought, editing etc
    public var delegate: ThoughtDetailDelegagte?
    
    let entryTV: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = true
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 101
        return tv
    }()
}

extension ThoughtDetailView {
    func setupView() {
        addSubview(topView)
        addSubview(entryTV)
        
        topView.setAnchor(top: safeTopAnchor, leading: safeLeadingAnchor, bottom: nil, trailing: safeTrailingAnchor, paddingTop: 0, paddingLeading: 2.5, paddingBottom: 0, paddingTrailing: 2.5)
        topView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        
        entryTV.frame = CGRect(x: 0, y: 230, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 230)
        
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
        titleLabel.frame = CGRect(x: 25, y: 55, width: ViewSize.SCREEN_WIDTH - 50, height: 100)
    }
    func styleView() {
        topView.backgroundColor = UIColor.init(hex: "161616")
        topView.layer.cornerRadius = 7
        
        iconLabel.font = .reBody(ofSize: 28)
        
        deleteButton.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
        
        titleLabel.font = .reBody(ofSize: 18)
        titleLabel.textColor = .white
    }
    func addContext() {
        self.titleLabel.text = self.title
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
