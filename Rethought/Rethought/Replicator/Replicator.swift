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
    
    // MARK: private vars
    let moc: NSManagedObjectContext
    var thoughts: [Thought]!
    let icons = [ThoughtIcon("💻"), ThoughtIcon("🚦"), ThoughtIcon("💭"), ThoughtIcon("💡")]
    let titles = ["Heres how you use a thought", "Feel blocked? keep track of it.", "Dont want to forget something your thinking about? put it in your thoughts", "Have a genius idea? jot it down"]
    
    func createThoughts() {
        print("creating thoughts...")
        for count in Range(0...3) {
            let thought = Thought(moc: moc)
            thought.createThought(title: titles[count], icon: icons[count])
            print(thought.icon)
        }
        saveReplicatorData()
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
