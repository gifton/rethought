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

//adding new thought view
class ThoughtCardController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //set card view
    public var card: ThoughtCard?
    
    //connect to dashbaord
    private var delegate: DashboardDelegate?
    
    //hold to-be-created objects
    private var newThought: Thought?
    private var newEntries: [Entry] = []
    
    init(withDelegate delegate: DashboardDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        card = ThoughtCard(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //once dashboard delegate is set, initiate card view
    func setCard(delegate: DashboardDelegate) {
        self.delegate = delegate
        card = ThoughtCard(delegate: self)
    }
}

extension ThoughtCardController: ThoughtCardDelegate {
    
    //navigate to new Entries
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
    
    //set view to visually confirm entry addition
    func addEntry(_ entry: Entry) {
        self.newEntries.append(entry)
        card?.didAddEntry(entry.type)
    }
    
    //create thought from card view objects
    //user defaults used to sace thoughtID, and keep naming concurrent
    func addThoughtComponents(title: String, icon: ThoughtIcon) {
        let thought = Thought(title: title, icon: icon.icon, date: Date())
        let defaults = UserDefaults.standard
        let thoughtNum: Int = defaults.integer(forKey: UserDefaults.Keys.thoughtID) + 1
        thought.ID = "T\(thoughtNum)"
        self.newThought = thought
        
        defaults.set(thoughtNum, forKey: UserDefaults.Keys.thoughtID)
    }
    
    //update dashboardcontrolller with new card state
    func updateState(state: ThoughtCardState) {
        delegate?.changeSize(size: state)
    }
    
    //save new thought validation
    func didPressSave() {
        guard let newThought = self.newThought else {
            print("could nit confirm new thought on save")
            return
        }
        
        //add any entryes into thought
        if newEntries.count > 0 {
            for entry in newEntries {
                newThought.addNew(entry: entry)
            }
        }
        savePost()
        print("----------------------------")
    }
}





//core data extension for saving
extension ThoughtCardController {
    
    //save new thought
    func savePost() {
        guard let newThought = self.newThought else {
            print("unable to get new thought")
            return
        }
        self.delegate?.saveNewThought(newThought)
    }
}
