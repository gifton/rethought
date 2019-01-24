//
//  DummyData.swift
//  rethought
//
//  Created by Dev on 12/9/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

extension DashboardViewModel {
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
            let rawimg = UIImage(named: "testImage3")!
            let size: CGSize = rawimg.calculateImageHeight()
            let newImg = rawimg.resizeImageWith(newSize: size)
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               detail: "Is how I met your mother better than friends?",
                               date: self.generateRandomDate(daysBack: 4)!,
                               icon: "🍇",
                               image: newImg)
            let entry2 = Entry(type: .text, thoughtID: id, detail: "It just... it dontr make no sense cuz, how could it be true? HOW? HOW HUH HOW??", date: generateRandomDate(daysBack: 2)!, icon: "🤸🏼‍♂️", title: "I guess the perplection continues...")
            
            let thought = Thought(title: "Is how I met your mother better than friends?", icon: "🍇", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            thought.setID(id)
            return thought
        }()
        
        let thought2: Thought = {
            let id = randomString(length: 12)
            let rawimg = UIImage(named: "testImage2")!
            let size: CGSize = rawimg.calculateImageHeight()
            let newImg = rawimg.resizeImageWith(newSize: size)
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               detail: "Should I love the private club?",
                               date: self.generateRandomDate(daysBack: 1)!,
                               icon: "⚽️",
                               image: newImg)
            let entry2 = Entry(type: .text, thoughtID: id, detail: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 5)!, icon: "🤸🏼‍♂️", title: "I guess, the private club should be avoided")
            
            let thought = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "⚽️", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            
            return thought
        }()
        let thought3: Thought = {
            let id = randomString(length: 12)
            let rawimg = UIImage(named: "testImage8")!
            let size: CGSize = rawimg.calculateImageHeight()
            let newImg = rawimg.resizeImageWith(newSize: size)
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               detail: "Gang members should always carry a ruler",
                               date: self.generateRandomDate(daysBack: 6)!,
                               icon: "🍬",
                               image: newImg)
            let entry2 = Entry(type: .text, thoughtID: id, detail: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 7)!, icon: "🤸🏼‍♂️", title: "I guess, the private club should be avoided")
            
            let thought = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "🍔", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            
            return thought
        }()
        let thought4: Thought = {
            let id = randomString(length: 12)
            let rawimg = UIImage(named: "testImage7")!
            let size: CGSize = rawimg.calculateImageHeight()
            let newImg = rawimg.resizeImageWith(newSize: size)
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               detail: "Should I love the private club?",
                               date: self.generateRandomDate(daysBack: 8)!,
                               icon: "⚽️",
                               image: newImg)
            let entry2 = Entry(type: .text, thoughtID: id, detail: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 10)!, icon: "🤸🏼‍♂️", title: "I guess, the private club should be avoided")
            
            let thought = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "💻", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            
            return thought
        }()
        let thought5: Thought = {
            let id = randomString(length: 12)
            let rawimg = UIImage(named: "testImage1")!
            let size: CGSize = rawimg.calculateImageHeight()
            let newImg = rawimg.resizeImageWith(newSize: size)
            let entry1 = Entry(type: .image,
                               thoughtID: id,
                               detail: "Man we really out here my guyyy",
                               date: self.generateRandomDate(daysBack: 10)!,
                               icon: "⚽️",
                               image: newImg)
            let entry2 = Entry(type: .text, thoughtID: id, detail: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 12)!, icon: "🤸🏼‍♂️", title: "I guess, the private club should be avoided")
            
            let thought = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "✊🏾", date: generateRandomDate(daysBack: 12)!, entries: [entry1, entry2])
            thought.setID(id)
            
            return thought
        }()
        
        return [thought1, thought2, thought3, thought4, thought5]
    }
}



