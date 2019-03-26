//
//  EntryListView.swift
//  Rethought-project
//
//  Created by Dev on 3/20/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//holding all mutating variables in a struct: EntrylistHeader
struct EntryListHeader {
    var type: EntryType
    var entryCount: Int
    var locationCount: Int
    
    init(ofType type: EntryType, entryCount: Int, locationCount: Int) {
        self.type = type
        self.entryCount = entryCount
        self.locationCount = locationCount
    }
}

class EntryListView: UIView {
    //initiate with:
    // - entryHeader Object
    init(header: EntryListHeader) {
        headerObject = header
        super.init(frame: Device.size.frame)
        backgroundColor = .white
        buildHeader(); buildTable()
    }
    
    private var headerObject: EntryListHeader
    
    // MARK: public
    public var tableView: UITableView!
    public var searchBar: UISearchBar!
    public var backBtn = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//all building funcs
extension EntryListView {
    
    //build header
    private func buildHeader() {
        let headerView = UIView()
        headerView.frame = CGRect(x: 20, y: 45, width: Device.size.width - 40, height: 260)
        headerView.backgroundColor = .clear
        addSubview(headerView)
        
        //build header objects
        let entryStack = buildHeaderLabels()
        
        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = .search
        searchBar.searchBarStyle = .minimal
        
        backBtn.setBackgroundImage(#imageLiteral(resourceName: "back-arrow"), for: .normal)
        
        
        //place objects
        backBtn.frame = CGRect(x: 0, y: 160, width: 34, height: 35)
        searchBar.frame = CGRect(x: 60, y: 160, width: Device.size.width - 95, height: 40)
        
        //add header objects to view
        headerView.addSubview(entryStack)
        headerView.addSubview(backBtn)
        headerView.addSubview(searchBar)
    }
    
    //build stack view for header
    func buildHeaderLabels() -> UIStackView {
        
        //build strings
        let entCount = "\(headerObject.entryCount) "
        let locCount = "\(headerObject.locationCount)"
        let entCountStaticText = "\(headerObject.type) entries"
        
        //initiate label
        let entryCountLabel = UILabel()
        let locationCountLabel = UILabel()
        let entryLabel = UILabel()
        
        //build attributed strings
        let entCountAttrString = NSAttributedString(string: entCount, attributes: [NSAttributedString.Key.foregroundColor : Device.colors.mainBlue])
        let entCountStaticAttrString = NSAttributedString(string: entCountStaticText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        let entCountFinalString = NSMutableAttributedString(attributedString: entCountAttrString)
        entCountFinalString.append(entCountStaticAttrString)
        
        //set labels to text
        entryCountLabel.attributedText = entCountFinalString
        locationCountLabel.text = "\(locCount) locations"
        entryLabel.text = "Entries"
        
        //style labels
        entryCountLabel.font = Device.font.body(ofSize: .small)
        locationCountLabel.font = Device.font.body(ofSize: .small)
        entryLabel.font = Device.font.title(ofSize: .title)
        
        //build stackViews
        let heightCalculation = (entryCountLabel.requiredHeight + entryCountLabel.requiredHeight + locationCountLabel.requiredHeight + 75)
        let stack = UIStackView(arrangedSubviews: [entryLabel, entryCountLabel, locationCountLabel], axis: .vertical)
        stack.setCustomSpacing(10, after: entryLabel)
        stack.setCustomSpacing(2, after: entryCountLabel)
        stack.frame = CGRect(x: 0, y: 10, width: Device.size.width, height: heightCalculation)
        stack.alignment = .leading
        
        return stack
    }
    
    func buildTable() {
        tableView = {
            let tv = UITableView(frame: CGRect(x: 0, y: 260, width: Device.size.width, height: Device.size.height - 260))
            tv.backgroundColor = Device.colors.offWhite
            tv.separatorStyle = .none
            return tv
        }()
        
        tableView.register(cellWithClass: EntryListTextCell.self)
        addSubview(tableView)
    }
}
