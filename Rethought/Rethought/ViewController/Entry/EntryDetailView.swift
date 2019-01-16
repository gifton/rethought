//
//  EntryDetailView.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//show individual entries in detail
class EntryDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        addGestureRecognizer(edgePan)
    }
    
    convenience init(frame: CGRect, entry: Entry, delegate: BackDelegate) {
        self.init(frame: frame)
        self.title    = entry.title
        self.icon     = entry.icon
        self.image = entry.image
        self.entryDescription = entry.description
        self.link = entry.link
        self.linkImage = entry.linkImage
        self.delegate = delegate
        self.entryType = entry.type
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //init all objects
    private let topView                     = UIView(frame: CGRect(x: 0, y: 0, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT * 0.117))
    private let deleteButton                = UIButton()
    private var iconLabel                   = UILabel()
    private let logo                        = UIImageView(image: #imageLiteral(resourceName: "Logo_with_bg"))
    
    //content recieved from entry
    public var entryType        : Entry.EntryType?
    public var title            : String?
    private var icon            : String?
    private var image           : UIImage?
    private var linkTitle       : String?
    private var entryDescription: String?
    private var linkImage       : UIImage?
    private var link            : String?
    //delegate for returning home, moving to new thought, editing etc
    public var delegate: BackDelegate?
    var content: Entry = Entry(title: "Giftons title")
    let entryTitleTV: UITextView = {
        let lbl = UITextView()
        lbl.font = .reTitle(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let entryDescriptionTV : UITextView = {
        let lbl = UITextView()
        lbl.font = .reBody(ofSize: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.borderColor = UIColor.red.cgColor
        lbl.layer.borderWidth = 3
        return lbl
    }()
}

extension EntryDetailView {
    func setupView() {
        anotherFuncName()
    }
    func styleView() {
        topView.backgroundColor = UIColor.init(hex: "161616")
        
        iconLabel.font = .reBody(ofSize: 28)
        
        deleteButton.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
        entryTitleTV.text = self.title ?? "this is the title"
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            delegate?.returnHome()
        }
    }
}

extension EntryDetailView {
    func addLink() {
    }
    func anotherFuncName() {
        
        let views : [UIView] = [logo, deleteButton, iconLabel]
        var start = CGPoint(x: 30, y: 35)
        let spacingConstant: CGFloat = 70.0
        
        iconLabel.frame.size = CGSize(width: 30, height: 35)
        iconLabel.text = self.icon!
        deleteButton.frame.size = CGSize(width: 30, height: 35)
        
        for innerView in views {
            topView.addSubview(innerView)
            innerView.frame.origin = start
            let newX = (spacingConstant + innerView.frame.width)
            start.x += newX
        }
        styleView()
        
        entryTitleTV.text = self.title ?? "Giftons test"
        entryDescriptionTV.text = self.entryDescription ?? "Giftons description"
        self.addSubview(entryTitleTV)
        self.addSubview(entryDescriptionTV)
        
        NSLayoutConstraint.activate ([
            entryTitleTV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            entryTitleTV.widthAnchor.constraint(equalToConstant: ViewSize.SCREEN_WIDTH - 50),
            entryTitleTV.topAnchor.constraint(equalTo: self.topAnchor, constant: (ViewSize.SCREEN_HEIGHT * 0.117) + 25),
            entryDescriptionTV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            entryDescriptionTV.topAnchor.constraint(equalTo: entryTitleTV.bottomAnchor, constant: 10),
            entryDescriptionTV.widthAnchor.constraint(equalToConstant: ViewSize.SCREEN_WIDTH - 50)
        ])
        
        print (entryTitleTV.frame)
    }
    func addImages() {
        
    }
}

