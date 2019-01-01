//
//  ThoughtDetailController.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailController: UIViewController{
    fileprivate var detailThought: Thought?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "55AFF8")
    }
}

extension ThoughtDetailController: BackDelegate {
    func returnHome() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ThoughtDetailController: DetailThoughtDelegate {
    
    var thought: Thought {
        get {
            return detailThought ?? Thought()
        }
        set {
            let detailView = ThoughtDetailView(frame: ViewSize.FRAME, thought: newValue, delegate: self)
            self.view = detailView
            
            
        }
    }
    
    func userTapped(on entryID: String) {
        let entries = self.thought.entries
        let entry = entries.filter{ $0.id == entryID }.first ?? Entry.init(title: "Not available")
        let vc = EntryDetailController()
        vc.entry = entry
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

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
            if let entry = entries![indexPath.row].images.first {
                 return entry.size.height
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
            let cell = entryTV.dequeueReusableCell(withIdentifier: TextEntryCell.identifier, for: indexPath) as! TextEntryCell
            cell.giveContext(with: entry)
            return cell
        default:
            let cell = entryTV.dequeueReusableCell(withIdentifier: ImageEntryCell.identifier, for: indexPath) as! ImageEntryCell
            cell.giveContext(with: entry)
            return cell
        }
    }
}
