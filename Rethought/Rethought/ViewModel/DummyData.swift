//
//  DummyData.swift
//  rethought
//
//  Created by Dev on 12/9/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


extension HomeViewController {
    
    func getDummyData(_ thoughtAmount: Int, entryAmount: Int) -> [Thought] {
        
        func getEntries() -> [Entry] {
            var entries = [Entry]()
            for _ in 0...entryAmount {
                let entry = Entry(type: Entry.EntryType.textEntry, id: randomString(length: 12), description: "I want to like the private club, but should there really be a cost associated with it?", date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!), icon: "test.png")
                entries.append(entry)
            }
            return entries
        }
        
        var dummyThoughts = [Thought]()
        
        for (_, count) in (0...thoughtAmount).enumerated() {
            let dummyThought = Thought(title: "Thought \(count)", description: "This is where you put ideas for apps, if the idea gets to large, create a seperate thought", icon: Thought.Icon.no, date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 100)!), entries: getEntries())
            
            dummyThoughts.append(dummyThought)
        }
        
        return dummyThoughts
        
    }
}
