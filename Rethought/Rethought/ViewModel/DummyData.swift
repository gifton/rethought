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
        var rawImages: [UIImage] = [UIImage(named: "testImage5")!, UIImage(named: "testImage3")!, UIImage(named: "testImage4")!, UIImage(named: "testImage2")!]
        var resizedImages = [UIImage]()
        for img in rawImages {
            let size: CGSize = img.calculateImageHeight()
            let newImg = img.resizeImageWith(newSize: size)
            resizedImages.append(newImg)
        }
        func getEntries(_ forThought: String, num: Int = Int.random(in: 0 ..< 10)) -> [Entry] {
            var entries = [Entry]()
            for _ in (0...entryAmount) {
                if num % 2 == 0 {
                    let entry = Entry(type: Entry.EntryType.text, thoughtID: forThought, description: string1 + string2 , date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!), icon: "test.png")
                    entries.append(entry)
                    
                } else {
                    let entry = Entry(type: .image, thoughtID: forThought, description: string1, date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!), icon: "🚫", images: resizedImages)
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
             let dummyThought = Thought(title: "Thought \(count)", icon: dummyIcons[count], date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 100)!), entries: getEntries(randomString(length: 12)))
            dummyThoughts.append(dummyThought)
        }
        
        return dummyThoughts
        
    }
    
    func generateRandomDate(daysBack: Int)-> Date?{
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
    
    
    func recieveDummyData() -> [Thought] {
        let thought1: Thought = {
            let id = randomString(length: 12)
            let rawimg = [UIImage(named: "testImage2")!, UIImage(named: "testImage3")!]
            var resizedImages = [UIImage]()
            for img in rawimg {
                let size: CGSize = img.calculateImageHeight()
                let newImg = img.resizeImageWith(newSize: size)
                resizedImages.append(newImg)
            }
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               description: "Is how I met your mother better than friends?",
                               date: self.generateRandomDate(daysBack: 4)!,
                               icon: "🍇",
                               images: resizedImages)
            let entry2 = Entry(type: .text, thoughtID: id, description: "It just... it dontr make no sense cuz, how could it be true? HOW? HOW HUH HOW??", date: generateRandomDate(daysBack: 2)!, icon: "🤸🏼‍♂️", title: "I guess the perplection continues...")
            
            let thought = Thought(title: "Is how I met your mother better than friends?", icon: "🍇", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            thought.setID(id)
            return thought
        }()
        
        let thought2: Thought = {
            let id = randomString(length: 12)
            let rawimg = [UIImage(named: "testImage5")!, UIImage(named: "testImage2")!]
            var resizedImages = [UIImage]()
            for img in rawimg {
                let size: CGSize = img.calculateImageHeight()
                let newImg = img.resizeImageWith(newSize: size)
                resizedImages.append(newImg)
            }
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               description: "Should I love the private club?",
                               date: self.generateRandomDate(daysBack: 4)!,
                               icon: "⚽️",
                               images: resizedImages)
            let entry2 = Entry(type: .text, thoughtID: id, description: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 2)!, icon: "🤸🏼‍♂️", title: "I guess, the private club should be avoided")
            
            let thought = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "⚽️", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            
            return thought
        }()
        let thought3: Thought = {
            let id = randomString(length: 12)
            let rawimg = [UIImage(named: "testImage1")!, UIImage(named: "testImage4")!]
            var resizedImages = [UIImage]()
            for img in rawimg {
                let size: CGSize = img.calculateImageHeight()
                let newImg = img.resizeImageWith(newSize: size)
                resizedImages.append(newImg)
            }
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               description: "Should I love the private club?",
                               date: self.generateRandomDate(daysBack: 4)!,
                               icon: "🍔",
                               images: resizedImages)
            let entry2 = Entry(type: .text, thoughtID: id, description: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 2)!, icon: "🤸🏼‍♂️", title: "I guess, the private club should be avoided")
            
            let thought = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "🍔", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            
            return thought
        }()
        let thought4: Thought = {
            let id = randomString(length: 12)
            let rawimg = [UIImage(named: "testImage4")!, UIImage(named: "testImage7")!]
            var resizedImages = [UIImage]()
            for img in rawimg {
                let size: CGSize = img.calculateImageHeight()
                let newImg = img.resizeImageWith(newSize: size)
                resizedImages.append(newImg)
            }
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               description: "Should I love the private club?",
                               date: self.generateRandomDate(daysBack: 4)!,
                               icon: "💻",
                               images: resizedImages)
            let entry2 = Entry(type: .text, thoughtID: id, description: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 2)!, icon: "🤸🏼‍♂️", title: "I guess, the private club should be avoided")
            
            let thought = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "💻", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            
            return thought
        }()
        let thought5: Thought = {
            let id = randomString(length: 12)
            let rawimg = [UIImage(named: "testImage8")!, UIImage(named: "testImage5")!]
            var resizedImages = [UIImage]()
            for img in rawimg {
                let size: CGSize = img.calculateImageHeight()
                let newImg = img.resizeImageWith(newSize: size)
                resizedImages.append(newImg)
            }
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               description: "Should I love the private club?",
                               date: self.generateRandomDate(daysBack: 4)!,
                               icon: "✊🏾",
                               images: resizedImages)
            let entry2 = Entry(type: .text, thoughtID: id, description: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 2)!, icon: "🤸🏼‍♂️", title: "I guess, the private club should be avoided")
            
            let thought = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "✊🏾", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            
            return thought
        }()
        
        return [thought1, thought2, thought3, thought4, thought5]
    }
}
