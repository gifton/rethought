//
//  ThoughtDetailView.swift
//  rethought
//
//  Created by Dev on 12/26/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//show individual thoughts in detail
class ThoughtDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor  = UIColor(hex: "FAFBFF")
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        addGestureRecognizer(edgePan)
    }
    
    convenience init(frame: CGRect, thought: Thought, delegate: ThoughtDetailDelegagte) {
        self.init(frame: frame)
        self.title    = thought.title
        self.icon     = thought.icon
        self.entries  = thought.entries
        self.delegate = delegate
        self.counts = thought.entryCount
        addContext()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //init all objects
    private let topView      = UIView()
    private let deleteButton = UIButton()
    private var iconLabel    = UILabel()
    private var titleTV      = UITextView()
    private let logo         = UIImageView(image: #imageLiteral(resourceName: "Logo_with_bg"))
    private var entryView    : EntryCountView?
    
    //content recieved from thought
    private var title:   String?
    private var icon:    String?
    public var entries:  [Entry]?
    private var counts: [String: Int]!
    
    //delegate for returning home, moving to new thought, editing etc
    public var delegate: ThoughtDetailDelegagte?
    
    let entryTV: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = true
//        tv.separatorStyle = .none
        tv.estimatedRowHeight = 110
        tv.rowHeight = UITableView.automaticDimension
        return tv
    }()
}

extension ThoughtDetailView {
    func setupView() {
        let media     = self.counts["media"] ?? 0
        let links     = self.counts["links"] ?? 0
        let recording = self.counts["recording"] ?? 0
        let text      = self.counts["text"] ?? 0
        
        entryView = EntryCountView(media: media , links: links, recordings: recording, text: text)
        
        addSubview(logo)
        addSubview(titleTV)
        addSubview(deleteButton)
        addSubview(iconLabel)
        addSubview(entryView!)
        addSubview(iconLabel)
        addSubview(entryTV)
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.leadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 15).isActive = true
        logo.topAnchor.constraint(equalTo: safeTopAnchor, constant: 15).isActive = true
        
        titleTV.frame = CGRect(x: 50, y: 90, width: ViewSize.SCREEN_WIDTH - 100, height: 91)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -25).isActive = true
        deleteButton.topAnchor.constraint(equalTo: safeTopAnchor, constant: 18).isActive = true
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -25).isActive = true
        iconLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 80).isActive = true
        
        entryTV.frame = CGRect(x: 0, y: 260, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 260)
        
        styleView()
    }
    func styleView() {
        titleTV.font = .reTitle(ofSize: 24)
        titleTV.backgroundColor = .clear
        
        deleteButton.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
    }
    func addContext() {
        self.titleTV.text = self.title
        self.iconLabel.text = self.icon
        
        entryTV.delegate = self
        entryTV.dataSource = self
        entryTV.register(EntryTextCell.self, forCellReuseIdentifier: EntryTextCell.identifier)
        entryTV.register(EntryImageCell.self, forCellReuseIdentifier: EntryImageCell.identifier)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            delegate?.returnHome()
        }
    }
}


//table view handlers
extension ThoughtDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userTapped(on: self.entries![indexPath.row].id)
    }
}

extension ThoughtDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if entries != nil {
            return entries!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if entries != nil {
            if let img = entries![indexPath.row].image {
                return img.size.height + 30
            } else {
                return 110
            }
        } else {
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = entries![indexPath.row]
        switch entry.type {
        case .text:
            let cell = entryTV.dequeueReusableCell(withIdentifier: EntryTextCell.identifier, for: indexPath) as! EntryTextCell
            cell.entry = entry
            return cell
        default:
            let cell = entryTV.dequeueReusableCell(withIdentifier: EntryImageCell.identifier, for: indexPath) as! EntryImageCell
            cell.giveContext(with: entry)
            return cell
        }
    }
}

