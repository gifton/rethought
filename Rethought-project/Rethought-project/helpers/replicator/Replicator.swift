import Foundation
import CoreData
import CoreLocation

protocol ReplicatorProtocol {
    func createThoughts()
}


class Replicator: ReplicatorProtocol {
    init(with moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: private Thought vars
    private let moc: NSManagedObjectContext
    private var thoughts: [Thought]!
    private let icons = [ThoughtIcon("💻"), ThoughtIcon("🚦" ),ThoughtIcon(" 💭"), ThoughtIcon("💡")]
    private let titles = ["Heres how you use a thought", "Feel blocked? you HAVE keep track of it.", "Dont want to forget something your thinking about? put it in your thoughts", "Have a genius idea? jot it down"]
    
    func createThoughts() {
        print("creating thoughts...")
        for (title, icon) in zip(titles, icons) {
            let thought: Thought = Thought.insert(in: moc, title: title, icon: icon.icon, location: CLLocation())
            createEntriesFor(thought: thought)
            print(thought.entries.count)
            print(title)
            print("-------------")
        }
        
        saveReplicatorData()
    }
    
    func createEntriesFor(thought: Thought) {
        print("setting entries...")
        
        //linkObj
        let entry1: LinkEntry = LinkEntry.insert(into: moc, link: "https://wesaturate.com", linkIcon: #imageLiteral(resourceName: "linkImagePlaceholder"), linkDescription: "wesaturate offers free high quality RAW and jpg photos", linkTitle: "Wesaturate", location: CLLocation(), detail: "i love wesat", thought: thought)
        //textEntries
        let entry2: TextEntry = TextEntry.insert(in: moc, title: "Can stratego save the world?", detail: "Strategists around the wirld claim that the board game stratego is the cure the world needs", thought: thought, location: CLLocation())

        let entry5: TextEntry = TextEntry.insert(in: moc, title: "Stratego teaches us to be gang members", detail: "Gang members have a really long history of producing the smartest and most gangy gang members...", thought: thought, location: CLLocation())
        let entry6: TextEntry = TextEntry.insert(in: moc, title: "Lipsum length test", detail: "r since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets co", thought: thought, location: CLLocation())

        //image obj's
        let entry3: MediaEntry = MediaEntry.insert(in: moc, image: #imageLiteral(resourceName: "IMG_4290"), detail: "This is an image designed for stratego", thought: thought, location: CLLocation())
        let entry4: MediaEntry = MediaEntry.insert(in: moc, image: #imageLiteral(resourceName: "IMG_0483"), detail: "This also has to do with stratego", thought: thought, location: CLLocation())
        
        //execute to calculate any runtime functions like Date() in the static func
        entry1.willSave()
        entry2.willSave()
        entry3.willSave()
        entry4.willSave()
        entry5.willSave()
        entry6.willSave()
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
