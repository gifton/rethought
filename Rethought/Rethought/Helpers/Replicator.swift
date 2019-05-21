//
//  Replicator.swift
//  Rethought
//
//  Created by Dev on 5/21/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation


import Foundation

protocol ReplicatorProtocol {
    func createThoughts()
}

class Replicator: ReplicatorProtocol {
    init(withMoc moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    var moc: NSManagedObjectContext
    var thoughts = [Thought]()
    let tp1 = ThoughtPreview(title: "Welcome to rethought", icon: "💭", location: CLLocation())
    let tp2 = ThoughtPreview(title: "This is a thought", icon: "🚦", location: CLLocation())
    let tp3 = ThoughtPreview(title: "Here's what another thought looks like", icon: "🎮", location: CLLocation())
    
    let ep1 = NoteBuilder(detail: "Notes let you save what you're thinking about in text form", title: "This is a note entry", forEntry: nil)
    let ep2 = NoteBuilder(detail: "this is another note", title: "We have another note now!", forEntry: nil)
    
    func createThoughts() {
        print("creating thoughts...")
        // thoughts
        let thought1 = Thought.insert(in: moc, withPreview: tp1)
        let thought2 = Thought.insert(in: moc, withPreview: tp2)
        let thought3 = Thought.insert(in: moc, withPreview: tp3)
        
        thought1.willSave()
        thought2.willSave()
        thought3.willSave()
        
        // entry for tp1
        let e1 = Entry.insertEntry(into: moc, location: CLLocation(), payload: ep1)
        e1.thought = thought1
        e1.willSave()
        let e2 = Entry.insertEntry(into: moc, location: CLLocation(), payload: ep2)
        e2.thought = thought1
        e2.willSave()
        
        // entry for tp2
        let e3 = Entry.insertEntry(into: moc, location: CLLocation(), payload: ep1)
        e3.thought = thought2
        e3.willSave()
        let e4 = Entry.insertEntry(into: moc, location: CLLocation(), payload: ep2)
        e4.thought = thought2
        e4.willSave()
        
        // entry for tp3
        let e5 = Entry.insertEntry(into: moc, location: CLLocation(), payload: ep1)
        e5.thought = thought1
        e5.willSave()
        let e6 = Entry.insertEntry(into: moc, location: CLLocation(), payload: ep2)
        e6.thought = thought2
        e6.willSave()
    }
    
    func attemptSave() {
        do {
            try moc.save()
            print("saved bruh!")
        } catch {
            print("THERE WAS AN ERROR")
            print(error)
        }
    }
}
