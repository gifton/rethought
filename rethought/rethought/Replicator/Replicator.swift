//
//  Replicator.swift
//  rethought
//
//  Created by Dev on 2/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import CoreData
class Replicator: ReplicatorProtocol {
    init(with moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: private Thought vars
    private let moc: NSManagedObjectContext
    private var thoughts: [Thought]!
    private let icons = [ThoughtIcon("💻"), ThoughtIcon("🚦"), ThoughtIcon("💭"), ThoughtIcon("💡")]
    private let titles = ["Heres how you use a thought", "Feel blocked? keep track of it.", "Dont want to forget something your thinking about? put it in your thoughts", "Have a genius idea? jot it down"]
    
    //put together completion handler for showing animation controller during save of replicated data
//    func setThoughts(completion: @escaping (UIViewController)-> ()) {
//        com
//    }
    func createThoughts() {
        print("creating thoughts...")
        for count in Range(0...3) {
            let thought = Thought(moc: moc)
            thought.createThought(title: titles[count], icon: icons[count])
            createEntriesFor(thought: thought)
            print(thought.entries.count)
        }
        
        saveReplicatorData()
    }
    
    func createEntriesFor(thought: Thought) {
        print("setting entries...")
        //linkobj
        let linkObject = EntryLinkObject(link: URL(string: "https://wesaturate.com")!, description: "Free RAW and JPG images", image: URL(string: "https://ws.imgix.net/photos/rgnk4m_zeppelin.jpg?w=1000&dpr=2&auto=compress&q=80&cs=tinysrgb&ixlib=js-1.0.6")!, shorthand: "wesaturate", title: "Free RAW and JPG photos")
        
        //linkObj
        let entry1: Entry = Entry.insertNewLinkEntry(into: moc, linkObject: linkObject!, thought: thought)
        //textEntries
        let entry2: Entry = Entry.insertNewTextEntry(into: moc, title: "Can stratego save the world?", detail: "Strategists around the wirld claim that the board game stratego is the cure the world needs", thought: thought)
        let entry5: Entry = Entry.insertNewTextEntry(into: moc, title: "Stratego teaches us to be gang members", detail: "Gang members have a really long history of producing the smartest and most gangy gang members...", thought: thought)
        //image obj's
        let entry3: Entry = Entry.insertNewImageEntry(into: moc, image: #imageLiteral(resourceName: "testImage1"), detail: "This has to do with stratego", thought: thought)
        let entry4: Entry = Entry.insertNewImageEntry(into: moc, image: #imageLiteral(resourceName: "testImage4"), detail: "This also has to do with stratego", thought: thought)
        
        //execute to calculate any runtime functions like Date() in the static func
        entry1.willSave()
        entry2.willSave()
        entry3.willSave()
        entry4.willSave()
        entry5.willSave()
    }
    
    func saveReplicatorData() {
        print("saving replicating data")
        do {
            try moc.save()
            print("saved bruh!")
        } catch let err {
            print("error saving replicating data")
            print(err)
        }
    }
}
