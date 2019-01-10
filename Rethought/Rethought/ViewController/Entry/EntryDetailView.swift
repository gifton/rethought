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
        self.images = entry.images
        self.entryDescription = entry.description
        self.link = entry.link
        self.linkImage = entry.linkImage
        self.delegate = delegate
        setupView()
        
        switch entry.type {
        case .image:
            addImages()
        case .text:
            addText()
        case .link:
            addLink()
        }
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
    public var title:            String?
    private var icon:             String?
    private var images:           [UIImage]?
    private var linkTitle:        String?
    private var entryDescription: String?
    private var linkImage:        UIImage?
    private var link:             String?
    //delegate for returning home, moving to new thought, editing etc
    public var delegate: BackDelegate?
    var content: Entry = Entry(title: "Giftons title")
}

extension EntryDetailView {
    func setupView() {
        addSubview(topView)
        
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
    }
    func styleView() {
        topView.backgroundColor = UIColor.init(hex: "161616")
        
        iconLabel.font = .reBody(ofSize: 28)
        
        deleteButton.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            delegate?.returnHome()
        }
    }
    
    private func setupView(for type: Entry.EntryType) {
        switch type {
        case .link:
            addLink()
        case .image:
            addImages()
        default:
            addText()
        }
    }
}

extension EntryDetailView {
    func addLink() {
    }
    func addText() {
        let entryTitle: UITextView = {
            let lbl = UITextView()
            lbl.font = .reTitle(ofSize: 14)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        let entryDescription: UITextView = {
            let lbl = UITextView()
            lbl.font = .reBody(ofSize: 12)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        entryTitle.text = self.title
        entryDescription.text = self.entryDescription
        self.addSubview(entryTitle)
        self.addSubview(entryDescription)
        NSLayoutConstraint.activate ([
            entryTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            entryTitle.widthAnchor.constraint(equalToConstant: ViewSize.SCREEN_WIDTH - 50),
            entryTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: (ViewSize.SCREEN_HEIGHT * 0.117) + 25),
            entryDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            entryDescription.topAnchor.constraint(equalTo: entryTitle.bottomAnchor, constant: 10),
            entryDescription.widthAnchor.constraint(equalToConstant: ViewSize.SCREEN_WIDTH - 50)
        ])
        
        print (entryTitle.text)
    }
    func addImages() {
        
    }
}
