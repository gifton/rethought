//
//  ThoughtCardController.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ThoughtCardController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public var card: ThoughtCard?
    private var delegate: DashboardDelegate?
    
    private var newThought: Thought?
    private var newEntries: [Entry] = []
    
    func setCard(delegate: DashboardDelegate) {
        self.delegate = delegate
        card = ThoughtCard(delegate: self)
    }
}

extension ThoughtCardController: ThoughtCardDelegate {
    func startNewEntry(_ type: Entry.EntryType) {
        switch type {
        case .text:
            let v = NewTextEntry()
            v.delegate = self
            v.parentThought = self.newThought
            self.navigationController?.pushViewController(v, animated: true)
        case .link:
            let v = NewLinkEntry()
            v.delegate = self
            v.parentThought = self.newThought
            self.navigationController?.pushViewController(v, animated: true)
        case .recording:
            let v = NewAudioEntry()
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
        self.newEntries.append(entry)
        card?.didAddEntry(entry.type)
    }
    
    func addThoughtComponents(title: String, icon: ThoughtIcon) {
        let thought = Thought(title: title, icon: icon.icon, date: Date())
        self.newThought = thought
    }
    
    func updateState(state: ThoughtCardState) {
        delegate?.changeSize(size: state)
    }
    
    func didPressSave() {
        print("btn pressed")
        guard let newThought = self.newThought else {
            print("thot err")
            return
        }
        if newEntries.count > 0 {
            for entry in newEntries {
                newThought.addNew(entry: entry)
            }
        }
        savePost()
        print("post saved!")
    }
}





//core data extension for saving
extension ThoughtCardController {
    
    func savePost() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let newThought = self.newThought else {
            print("unable to get new thought")
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let thought = ThoughtModel(context: managedContext)
        thought.date = newThought.date
        thought.icon = newThought.icon
        thought.id = newThought.ID
        thought.title = newThought.title
        
        for entry in newEntries {
            let entryOut = EntryModel(context: managedContext)
            entryOut.date = Date()
            entryOut.detail = entry.detail
            entryOut.addToThoughtModel(thought)
            thought.addToEntryModel(entryOut)
        }
        do {
            let save = try managedContext.save()
        } catch let err  {
            print("----------error-----------")
            print(err)
        }
        print("saved thought!")
    }
}
