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
    
    convenience init(frame: CGRect, entry: Entry, delegate: EntryDetailDelegate) {
        self.init(frame: frame)
        self.title    = entry.title
        self.icon     = entry.icon
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
    private let logo                        = UIImageView(image: #imageLiteral(resourceName: "Logo_with_bg"))
    
    //content recieved from thought
    private var title:   String?
    private var icon:    String?
    public var entries:  [Entry]?
    //delegate for returning home, moving to new thought, editing etc
    public var delegate: EntryDetailDelegate?
    var content = Entry(title: "Giftons title")
}

extension EntryDetailView {
    func setupView() {
        addSubview(topView)
        
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
    }
    func styleView() {
        topView.backgroundColor = UIColor.init(hex: "161616")
        
        iconLabel.font = .reBody(ofSize: 28)
        
        deleteButton.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
    }
    func addContext() {
        self.iconLabel.text = self.icon
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            delegate?.returnHome()
        }
    }
}
