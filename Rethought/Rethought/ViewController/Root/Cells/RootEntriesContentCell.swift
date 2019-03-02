//
//  Cells.swift
//  rethought
//
//  Created by Dev on 2/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RootEntriesContentCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews(); styleViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String { return "RootEntriesContentCell" }
    
    //MARK: Views
    let entryTitle: UILabel = {
        let lbl = UILabel()
        lbl.addText(size: 25, font: .title, string: "Entries")
        lbl.textColor = UIColor(hex: "3D3D46")
        
        return lbl
    }()
    
    let allEntries: UIButton = {
        let btn = UIButton()
        btn.addAttText(color: UIColor(hex: "E91E63"), size: 14, font: .body, string: "all entries")
        
        return btn
    }()
    
    let entryView = EntryTypeView(frame: CGRect(x: 20, y: 20, width: ViewSize.SCREEN_WIDTH - 20, height: 129))
    
    let randomEntry: UIButton = {
        let btn = UIButton()
        let buttonColor = UIColor(hex: "3D3D46")
        btn.backgroundColor = .clear
        btn.layer.borderColor = buttonColor.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.addAttText(color: buttonColor, size: 18, font: .body, string: "random entry")
        
        return btn
    }()
    
    let newThought: UIButton = {
        let btn = UIButton()
        let buttonColor = UIColor(hex: "BF6C80")
        btn.backgroundColor = buttonColor
        btn.addAttText(color: .white, size: 18, font: .body, string: "new thought")
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    func addViews() {
        addSubview(entryTitle)
        addSubview(allEntries)
        addSubview(entryView)
        addSubview(randomEntry)
        addSubview(newThought)
        
        entryTitle.frame  = CGRect(x: 20, y: 5, width: 100, height: 30)
        allEntries.frame  = CGRect(x: ViewSize.SCREEN_WIDTH - (80 + 20), y: 17, width: 80, height: 16)
        entryView.frame   = CGRect(x: 0, y: 35, width: ViewSize.SCREEN_WIDTH - 15, height: 129)
        randomEntry.frame = CGRect(x: 20, y: 195 + 10, width: 150, height: 35)
        newThought.frame  = CGRect(x: ViewSize.SCREEN_WIDTH - (150 + 20), y: 195 + 10, width: 150, height: 35)
    }
    
    func styleViews() {
        
    }
    
    func showEntries(ofType type: EntryType) {
        
    }
    
    func startNewThought() {
        
    }
    
    func randomThought() {
        
    }
}
