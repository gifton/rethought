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
        styleView()
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
        
        setupView(for: entry.type)
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
    private var title:            String?
    private var icon:             String?
    private var images:           [UIImage]?
    private var linkTitle:        String?
    private var entryDescription: String?
    private var linkImage:        UIImage?
    private var link:             String?
    //delegate for returning home, moving to new thought, editing etc
    public var delegate: BackDelegate?
    var content = Entry(title: "Giftons title")
}

extension EntryDetailView {
    func setupView() {
        addSubview(topView)
        
        let views : [UIView] = [logo, deleteButton, iconLabel]
        var start = CGPoint(x: 25, y: 35)
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
    }
    func styleView() {
        topView.backgroundColor = UIColor.init(hex: "161616")
        
        iconLabel.font = .reBody(ofSize: 28)
        
        deleteButton.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
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
    
    func addLink() {
        print("its a link!")
    }
    func addText() {
        print("its text!")
    }
    func addImages() {
        print("they're images!")
    }
}
