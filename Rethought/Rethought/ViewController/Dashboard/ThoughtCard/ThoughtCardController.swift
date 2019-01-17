//
//  ThoughtCardController.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtCardController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public var card: ThoughtCard?
    private var delegate: DashboardDelegate?
    
    private var newThought: Thought?
    private var newEntries: [Entry]?
    
    func setCard(delegate: DashboardDelegate) {
        self.delegate = delegate
        card = ThoughtCard(delegate: self)
    }
}

extension ThoughtCardController: ThoughtCardDelegate {
    func startNewEntry(_ type: Entry.EntryType) {
        switch type {
        case .text, .link:
            let v = NewTextEntry()
            v.delegate = self
            v.parentThought = self.newThought
            self.navigationController?.pushViewController(v, animated: true)
        default:
            let v = NewImageEntry()
            v.delegate = self
            v.parentThought = self.newThought
            self.navigationController?.pushViewController(v, animated: true)
        }
        
        
    }
    
    func addEntry(_ entry: Entry) {
        self.newEntries?.append(entry)
    }
    
    func addThoughtComponents(title: String, icon: ThoughtIcon) {
        print("added string \(title) to thought")
    }
    
    func updateState(state: ThoughtCardState) {
        delegate?.changeSize(size: state)
    }
    
    
}
