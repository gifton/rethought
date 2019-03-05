//
//  CreateNewThoughtCell.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


class CreateNewThoughtCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell(); styleCell()
    }
    
    public static var identifier: String { return "CreateNewThoughtCell" }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let iconTextView = EmojiDisplay(frame: CGRect(x: 20, y: 15, width: 56, height: 56), emoji: ThoughtIcon("💡"))
    let titleTextView = UITextView(frame: CGRect(x: 91, y: 15, width: ViewSize.SCREEN_WIDTH - 111, height: 70))
    
    private func setCell() {
        addSubview(iconTextView)
        addSubview(titleTextView)
    }
    
    public func setDelagate(_ connector: ThinkDelegate) {
        self.connector = connector
    }
    
    private var connector: ThinkDelegate?
    
    private func styleCell() {
        titleTextView.text = "Add a short description"
        titleTextView.font = .reTitle(ofSize: 16)
        titleTextView.textColor = UIColor(hex: "3D3D46")
        titleTextView.textAlignment = .left
        
        iconTextView.backgroundColor = UIColor(hex: "ECECEC")
    }
}
