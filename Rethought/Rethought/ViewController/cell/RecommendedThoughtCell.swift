//
//  RecommendedThoughtCell.swift
//  rethought
//
//  Created by Dev on 12/23/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RecommendedThoughtCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    private var titleLabel      = UILabel()
    private var iconWrapper     = UIView()
    private var iconLabel       = UILabel()
    private var linkLabel       = UILabel()
    private var entryLabel      = UILabel()
    private var mediaLabel      = UILabel()
    private var dayCountLabel   = UILabel()
    var backgroundImage         = UIImageView()
    private var thoughtCell     = UIView()
    
    var welcomeTitle: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: 12, width: 300, height: 25))
        lbl.text = "Recommended Thought"
        lbl.font = .retitle(ofSize: 20)
        lbl.textColor = .white
        
        return lbl
    }()
    private let cell: UIImageView = {
        let size = ViewSize()
        let iv = UIImageView(frame: size.largeTile)
        iv.image = #imageLiteral(resourceName: "ReccomendedThought")
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private var titleText: String?
    private var icon: String?
    private var linkCount: Int?
    private var entryCount: Int?
    private var mediaCount: Int?
    private var dayCount: Int?
    
    private func setupCell() {
        let stack = createStack()
        
        addSubview(cell)
        
        cell.addSubview(welcomeTitle)
        cell.addSubview(thoughtCell)
        
        thoughtCell.addSubview(iconWrapper)
        thoughtCell.addSubview(iconLabel)
        thoughtCell.addSubview(stack)
        thoughtCell.addSubview(titleLabel)
        thoughtCell.addSubview(dayCountLabel)
        
        styleCell()
    }
    
    //createStack() refactored to keep setupCell() clean as possible
    private func createStack() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [linkLabel, entryLabel, mediaLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.frame = CGRect(x: 77, y: 45, width: 150, height: 20)
        return stackView
    }
    
    private func styleCell() {
        thoughtCell.frame.size = CGSize(width: 325, height: 70)
        thoughtCell.center.y = cell.center.y
        thoughtCell.center.x += 12.5
        thoughtCell.layer.cornerRadius = 5
        thoughtCell.backgroundColor = .lightGray
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.shadowRadius = 8
        
        welcomeTitle.layer.shadowColor = UIColor.black.cgColor
        welcomeTitle.layer.shadowRadius = 3.0
        welcomeTitle.layer.shadowOpacity = 1.0
        welcomeTitle.layer.shadowOffset = CGSize(width: 4, height: 4)
        welcomeTitle.layer.masksToBounds = false
        
        iconWrapper.frame = CGRect(x: 10, y: 7, width: 56, height: 56)
        iconWrapper.backgroundColor = .white
        iconWrapper.layer.cornerRadius = 5
        
        iconLabel.frame = iconWrapper.frame
        iconLabel.textAlignment = .center
        iconLabel.font = UIFont.retitle(ofSize: 30)
        
        titleLabel.frame = CGRect(x: 76, y: 7, width: 250, height: 30)
        
        let lbls = [linkLabel, mediaLabel, dayCountLabel, entryLabel]
        
        for lbl in lbls {
            lbl.font = .reBody(ofSize: 12)
            lbl.textColor = .white
        }
        self.titleLabel.font = .retitle(ofSize: 16)
        self.titleLabel.textColor = .white
        
        dayCountLabel.frame = CGRect(x: (thoughtCell.frame.width - 100), y: 12, width: 100, height: 25)
        dayCountLabel.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String { return "RecommendedThoughtExpandedCell" }
    
    //func called in cellForRowAt: to add in info explicitely
    public func giveContext(_ context: ThoughtPreviewLarge) {
        self.titleText = context.title
        self.icon = context.icon
        self.linkCount = context.entryCount["links"]
        self.entryCount = context.entryCount["entries"]
        self.mediaCount = context.entryCount["media"]
        self.dayCount = 6
        recievedContext()
    }
    
    private func recievedContext() {
        //check for all variables
        guard let title       = self.titleText else { return }
        guard let icon        = self.icon else { return }
        guard let linkCount   = self.linkCount else { return }
        guard let entryCount  = self.entryCount else { return }
        guard let mediaCount  = self.mediaCount else { return }
        guard let dayCount    = self.dayCount else { return }
        
        //assign variables to objects
        self.titleLabel.text = title
        self.iconLabel.text = icon
        self.linkLabel.text = String(describing: linkCount) + " Links"
        self.entryLabel.text = String(describing: entryCount) + " Entries"
        self.mediaLabel.text = String(describing: mediaCount) + " media"
        self.dayCountLabel.text = String(describing: dayCount) + "Days"
    }
}
