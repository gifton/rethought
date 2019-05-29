
import Foundation
import UIKit
import CoreData
import CoreLocation


import Foundation

protocol ReplicatorProtocol {
    func createThoughts()
}

// when user opens app for first time, load example thoughts into DB for their conveniance
class Replicator: ReplicatorProtocol {
    // create the thoughts
    let tp1 = ThoughtPreview(title: "Welcome to rethought", icon: "💭", location: CLLocation())
    let tp2 = ThoughtPreview(title: "Feel blocked? keep track of it.", icon: "🚦", location: CLLocation())
    let tp3 = ThoughtPreview(title: "Dont want to forget something your thinking about? put it in your thoughts", icon: "🎮", location: CLLocation())
    let tp4 = ThoughtPreview(title: "Dont want to forget something your thinking about? put it in your thoughts", icon: "🎮", location: CLLocation())
    func createThoughts() {
        print("creating thooughts from preview...")
        [tp1, tp2, tp3, tp4].forEach { (preview) in
            var thought = Thought.insert(in: moc, withPreview: preview)
            print(thought.title)
            setEntriesFor(&thought)
        }
        
        attemptSave()
    }
    
    func setEntriesFor(_ thought: inout Thought) {
        
        print("setting entries for thought")
        // create the entry objects with thought relationship
        let entry1 = createEntry(forThought: thought)
        let entry2 = createEntry(forThought: thought)
        let entry3 = createEntry(forThought: thought)
        let entry4 = createEntry(forThought: thought)
        
        // create the builder objects
        let ep1 = NoteBuilder(detail: "Notes let you save what you're thinking about in text form", title: "This is a note entry", forEntry: entry1)
        let ep2 = NoteBuilder(detail: "this is another note", title: "We have another note now!", forEntry: entry2)
        let ep3 = PhotoBuilder(photo: #imageLiteral(resourceName: "welcomeCardGraphic"), userDetail: "This is my photo!", forEntry: entry3)
        let ep4 = LinkBuilder(link: "https://wesaturate.com",
                              rawIconUrl: "https://ws.imgix.net/photos/rgnk4m_zeppelin.jpg?w=1000&dpr=2&auto=compress&q=80&cs=tinysrgb&ixlib=js-1.0.6",
                              userDetail: "This is my website!",
                              title: "Free RAW and JPG images",
                              forEntry: entry4)
        
        // set builder objects to respective entries
        
        let _ = NoteEntry.insert(into: moc, builder: ep1)
        let _ = NoteEntry.insert(into: moc, builder: ep2)
        let _ = PhotoEntry.insert(into: moc, builder: ep3)
        let _ = LinkEntry.insert(into: moc, builder: ep4)
    }
    
    func createEntry(forThought thought: Thought) -> Entry {
        let entry: Entry = Entry.insert(into: moc, withlocation: CLLocation(), for: thought)
        return entry
    }
    
    init(withMoc moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    let moc: NSManagedObjectContext
    func attemptSave() {
        do {
            try moc.save()
            print("saved bruh!")
        } catch {
            print("THERE WAS AN ERROR SAVING IN REPLICATOR")
            print(error)
        }
    }
}
