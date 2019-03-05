//
//  RootThoughtCell.swift
//  rethought
//
//  Created by Dev on 2/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RootThoughtCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String {
        return "RootThoughtsCell"
    }
    
    public func set(with thought: ThoughtPreview) {
        print("setting from Rooththoughcell")
        self.icon       = thought.icon.icon
        self.entryCount = thought.entryCount
        self.location   = String(describing: thought.location)
        self.date       = thought.createdAt
        self.title      = thought.title
        buildMain(); buildView(); styleView()
    }
    
    // MARK: private variables
    private var icon: String!
    private var entryCount: EntryCount!
    private var location: String!
    private var date: Date!
    private var title: String!
    
    // MARK: Objects
    let main = UIView()
    let iconLabel           = UILabel()
    let titleLabel          = UILabel()
    let locationLabel       = UILabel()
    let textEntryCount      = UILabel()
    let imageEntryCount     = UILabel()
    let linkEntryCount      = UILabel()
    let recordingEntryCount = UILabel()
    let dateLabel           = UILabel()
    
    private func buildMain() {
        main.frame = CGRect(x: 15, y: 7.5, width: ViewSize.SCREEN_WIDTH - 30, height: 200)
        addSubview(main)
        main.backgroundColor = UIColor(hex: "F9F9F9")
        main.layer.cornerRadius = 8
    }
    
    private func buildView() {
        
        iconLabel.text = icon
        titleLabel.text = title
        textEntryCount.text = "\(entryCount.text) entries"
        imageEntryCount.text = "\(entryCount.image) images"
        linkEntryCount.text = "\(entryCount.link) links"
        recordingEntryCount.text = "\(entryCount.recording) recordings"
        locationLabel.text = "Seattle, washington"
        dateLabel.getStringFromDate(date: date)
        
        main.addSubview(iconLabel)
        main.addSubview(titleLabel)
        main.addSubview(countStack())
        main.addSubview(timeLocationStack())
        
        
        iconLabel.frame = CGRect(x: 20, y: 20, width: 56, height: 56)
        titleLabel.frame = CGRect(x: 90, y: 20, width: ViewSize.SCREEN_WIDTH - 125, height: heightForView(text: title, font: UIFont.boldSystemFont(ofSize: 20), width: ViewSize.SCREEN_WIDTH - 110))
        
    }
    
    func countStack() -> UIStackView {
        let sv = UIStackView(arrangedSubviews: [textEntryCount, imageEntryCount, linkEntryCount, recordingEntryCount])
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.frame = CGRect(x: 30, y: 90, width: 200, height: 90)
        
        return sv
    }
    
    func timeLocationStack() -> UIStackView {
        let sv = UIStackView(arrangedSubviews: [locationLabel, dateLabel])
        sv.frame = CGRect(x: 250, y: main.frame.height - 60, width: 150, height: 40)
        sv.distribution = .fillEqually
        sv.axis = .vertical
        
        return sv
    }
    
    private func styleView() {
        iconLabel.text = icon
        iconLabel.font = .reBody(ofSize: 25)
        iconLabel.backgroundColor = .white
        iconLabel.textAlignment = .center
        iconLabel.layer.cornerRadius = 11
        iconLabel.layer.masksToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        
        let entryViews = [textEntryCount, imageEntryCount, linkEntryCount, recordingEntryCount]
        entryViews.forEach { (lbl) in
            lbl.font = UIFont.reBodyLight(ofSize: 12)
        }
    
        locationLabel.font = .boldSystemFont(ofSize: 12)
        dateLabel.font = .reBody(ofSize: 12)
        
    }
    
}
