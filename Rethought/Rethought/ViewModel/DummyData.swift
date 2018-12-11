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
    
    func getDummyDataForReccomededThoughts(_ thoughtAmount: Int, entryAmount: Int) -> [Thought] {
        
        func getEntries() -> [Entry] {
            var entries = [Entry]()
            for _ in 0...entryAmount {
                let entry = Entry(type: Entry.EntryType.text, thoughtID: randomString(length: 12), description: "I want to like the private club, but should there really be a cost associated with it?", date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!), icon: "test.png")
                entries.append(entry)
            }
            return entries
        }
        
        var dummyThoughts = [Thought]()
        let dummyIcons = ["😂", "⚽️", "♥️", "🙅‍♂️", "🎄", "✊🏾"]
        
        for (_, count) in (0...thoughtAmount).enumerated() {
            let dummyThought = Thought(title: "Thought \(count)", description: "This is where you put ideas for apps, if the idea gets to large, create a seperate thought", icon: dummyIcons[count], date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 100)!), entries: getEntries())
            
            dummyThoughts.append(dummyThought)
        }
        
        return dummyThoughts
        
    }
}
