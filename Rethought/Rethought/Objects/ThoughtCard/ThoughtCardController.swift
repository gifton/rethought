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
    private var context: NSManagedObjectContext? {
        get {
            return delegate?.context
        }
    }
    
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
    func startNewEntry(_ type: EntryType) {
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
    
    //thought type savings
    func addTextEntry(title: String, detail: String) {
        guard let context = delegate?.context else { fatalError("unable to recieve context from delegate")}
        let _ = Entry.insertNewTextEntry(into: context, title: title, detail: description)
    }
    
    func addImageEntry(image: UIImage, detail: String) {
        guard let context = delegate?.context else { fatalError("unable to recieve context from delegate")}
        let _ = Entry.insertNewImageEntry(into: context, image: image, detail: detail)
    }
    
    func addLinkEntry(link: EntryLinkObject) {
        guard let context = delegate?.context else { fatalError("unable to recieve context from delegate")}
        let _ = Entry.insertNewLinkEntry(into: context, linkObject: link)
    }
    
    func addRecordingEntry(title: String, detail: String) {
        print("daved recording")
    }
    
    //create thought from card view objects
    //user defaults used to sace thoughtID, and keep naming concurrent
    func buildThought(title: String, icon: ThoughtIcon) {
        guard let context = delegate?.context else { fatalError("unable to recieve context from delegate")}
        let thought = Thought(context: context)
        self.newThought = thought
    }
    
    //update dashboardcontrolller with new card state
    func updateState(state: ThoughtCardState) {
        delegate?.changeSize(size: state)
    }
    
    //save new thought validation
    func didPressSave() {
        guard let _ = self.newThought, let _ = self.context else {
            print("could not confirm new thought on didPressSave")
            return
        }
        savePost()
        print("----------------------------")
    }
}

//core data extension for saving
extension ThoughtCardController {
    
    //save new thought
    func savePost() {
        do {
            try context?.save()
        } catch let err {
            print("unable to save new thought in thoughtCard")
            print(err)
        }
    }
}
