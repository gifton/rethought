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
//        addViews(); styleViews()
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
    
    let textButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        btn.backgroundColor = UIColor(hex: "30B27E")
        btn.setTitle("text", for: .normal)
        btn.layer.cornerRadius = 5
        btn.contentHorizontalAlignment = .left
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        btn.setImage(#imageLiteral(resourceName: "arrow-alt-right"), for: .normal)
        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -10).isActive = true
        btn.imageView?.centerYAnchor.constraint(equalTo: btn.centerYAnchor, constant: 0.0).isActive = true
        
        return btn
    }()
    let imageButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        btn.backgroundColor = UIColor(hex: "138FC9")
        btn.setTitle("image", for: .normal)
        btn.layer.cornerRadius = 5
        btn.contentHorizontalAlignment = .left
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        btn.setImage(#imageLiteral(resourceName: "arrow-alt-right"), for: .normal)
        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -10).isActive = true
        btn.imageView?.centerYAnchor.constraint(equalTo: btn.centerYAnchor, constant: 0.0).isActive = true
        
        return btn
    }()
    let linkButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        btn.backgroundColor = UIColor(hex: "994282")
        btn.setTitle("link", for: .normal)
        btn.layer.cornerRadius = 5
        btn.contentHorizontalAlignment = .left
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        btn.setImage(#imageLiteral(resourceName: "arrow-alt-right"), for: .normal)
        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -10).isActive = true
        btn.imageView?.centerYAnchor.constraint(equalTo: btn.centerYAnchor, constant: 0.0).isActive = true
        
        return btn
    }()
    let recordingButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        btn.backgroundColor = UIColor(hex: "FF8D77")
        btn.setTitle("recording", for: .normal)
        btn.layer.cornerRadius = 5
        btn.contentHorizontalAlignment = .left
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        1
        btn.setImage(#imageLiteral(resourceName: "arrow-alt-right"), for: .normal)
        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -10).isActive = true
        btn.imageView?.centerYAnchor.constraint(equalTo: btn.centerYAnchor, constant: 0.0).isActive = true
        
        print(btn.heightAnchor)
        return btn
    }()
    
    let randomEntry: UIButton = {
        let btn = UIButton()
        let buttonColor = UIColor(hex: "3D3D46")
        
        btn.backgroundColor = .clear
        btn.layer.borderColor = buttonColor.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.addAttText(color: buttonColor, size: 18, font: .body, string: "I'm feeling lucky...")
        
        return btn
    }()
    
    func addViews() {
        let entryView = UIStackView(arrangedSubviews: [textButton, imageButton, recordingButton, linkButton])
        entryView.axis = .vertical
        entryView.distribution = .equalSpacing
        entryView.spacing = 5
        entryView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(entryTitle)
        addSubview(allEntries)
        addSubview(entryView)
        addSubview(randomEntry)
        
        entryTitle.frame  = CGRect(x: 20, y: 5, width: 100, height: 30)
        allEntries.frame  = CGRect(x: ViewSize.SCREEN_WIDTH - (80 + 20), y: 17, width: 80, height: 16)
        entryView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        entryView.topAnchor.constraint(equalTo: topAnchor, constant: 45).isActive = true
        entryView.widthAnchor.constraint(equalToConstant: ViewSize.SCREEN_WIDTH - 20).isActive = true
        entryView.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        randomEntry.frame = CGRect(x: 20, y: 195 + 10, width: 250, height: 35)
        
        print("============================================")
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
