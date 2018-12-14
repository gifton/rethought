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
        let string1 = "I want to like the private club, but should there really be a cost associated with it?"
        let string2 = "This is where you put ideas for apps, if the idea gets to large, create a seperate thought"
        var dummyThoughts = [Thought]()
        var dummyIcons = ["😂", "⚽️", "♥️", "🙅‍♂️", "🎄", "✊🏾", "🍤", "🍔", "🥪", "💻"]
        var images: [UIImage] = [UIImage(named: "testImage1")!, UIImage(named: "testImage2")!]
        func getEntries(_ forThought: String, num: Int = Int.random(in: 0 ..< 10)) -> [Entry] {
            var entries = [Entry]()
            for _ in (0...entryAmount) {
                if num % 2 == 0 {
                    let entry = Entry(type: Entry.EntryType.text, thoughtID: forThought, description: string1 + string2 , date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!), icon: "test.png")
                    entries.append(entry)
                    
                } else {
                    let entry = Entry(type: .image, thoughtID: forThought, description: string1, date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!), icon: "🚫", images: images)
                    entries.append(entry)
                }
                
            }
            return entries
        }
        
        
        
        for (_, count) in (0...thoughtAmount).enumerated() {
            if (count % 10 == 0) {
                for icon in dummyIcons {
                    dummyIcons.append(icon)
                }
            }
             let dummyThought = Thought(title: "Thought \(count)", description: string2, icon: dummyIcons[count], date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 100)!), entries: getEntries(randomString(length: 12)))
            dummyThoughts.append(dummyThought)
        }
        
        return dummyThoughts
        
    }
}
