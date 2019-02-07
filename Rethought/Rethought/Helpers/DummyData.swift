////
////  DummyData.swift
////  rethought
////
////  Created by Dev on 12/9/18.
////  Copyright © 2018 Wesaturate. All rights reserved.
////
//
import Foundation
import UIKit

extension ThoughtDetailView {

    func generateRandomDate(daysBack: Int)-> Date{
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
        return randomDate ?? Date()
    }

    func getDummyData() -> Thought{
        let id = randomString(length: 12)
        let rawimg = UIImage(named: "testImage1")!
        let size: CGSize = rawimg.calculateImageHeight()
        let newImg = rawimg.resizeImageWith(newSize: size)
        let entry1 = Entry(type: .image,
                           thoughtID: id,
                           detail: "Man we really out here my guyyy",
                           date: self.generateRandomDate(daysBack: 10),
                           image: newImg)
        let entry2 = Entry(type: .text, thoughtID: id, detail: "From what I can gather, the private club is a void in which poeople all simultaniously yell into to see how makes it out", date: generateRandomDate(daysBack: 12), title: "I guess, the private club should be avoided")
        let entry3 = Entry(type: .text, thoughtID: id, detail: "Listen, i aint saying it twice, if you know you know, and if you a gang member, yousagangmember.  I didnt think this would be such a legitimate issue in todays society.  #letGangmembersBeGangmembers", date: generateRandomDate(daysBack: 15), title: "#letGangMembersBeGangMembers")
        let rawImgTwo = UIImage(named: "testImage2")
        let size2: CGSize = rawImgTwo!.calculateImageHeight()
        let newImg2 = rawImgTwo!.resizeImageWith(newSize: size2)
        let entry4 = Entry(type: .image,
                           thoughtID: id,
                           detail: "Man we really out here my guyyy",
                           date: self.generateRandomDate(daysBack: 14),
                           image: newImg2)
        let entry5 = Entry(type: .link, thoughtID: id, detail: "Free RAW and jpeg photos", date: generateRandomDate(daysBack: 24), link: "https://wesaturate.com", linkImage: #imageLiteral(resourceName: "wesat_logo"), linkTitle: "Wesaturate.com")

        let rawimgThree = UIImage(named: "testImage3")!
        let sizeThree: CGSize = rawimgThree.calculateImageHeight()
        let newImgThree = rawimgThree.resizeImageWith(newSize: sizeThree)
        let entry6 = Entry(type: .image,
                           thoughtID: id,
                           detail: "Man we really out here my guyyy",
                           date: self.generateRandomDate(daysBack: 10),
                           image: newImgThree)
        let entry7 = Entry(type: .text, thoughtID: id, detail: "Lorem upsum blah blah blah This is a test detail moment for an image", date: generateRandomDate(daysBack: 18), title: "We're for eachotherrrrr")
        let entry8 = Entry(type: .text, thoughtID: id, detail: "Top Things To See During A Holiday In Hong Kong and Many other places.", date: generateRandomDate(daysBack: 19), title: "#letGangMembersBeGangMembers")
        let rawImgFour = UIImage(named: "testImage4")
        let sizeFour: CGSize = rawImgFour!.calculateImageHeight()
        let newImgFour = rawImgFour!.resizeImageWith(newSize: sizeFour)
        let entry9 = Entry(type: .image,
                           thoughtID: id,
                           detail: "Should images be this good?",
                           date: self.generateRandomDate(daysBack: 23),
                           image: newImgFour)
        let entry10 = Entry(type: .link, thoughtID: id, detail: "Free RAW and jpeg photos", date: generateRandomDate(daysBack: 34), link: "https://gifton.io", linkImage: #imageLiteral(resourceName: "linkImage"), linkTitle: "Gifton.io")

        let output = Thought(title: "From what I can gather, when you ball out, you fall out", icon: "✊🏾", date: generateRandomDate(daysBack: 12), entries: [entry1, entry2, entry3, entry4, entry5, entry6, entry7, entry8, entry9, entry10])
        output.setID(id)

        return output
    }
}
