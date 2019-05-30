
import Foundation
import UIKit
import CoreData
import CoreLocation

// handle Thought Detail logic
class ThoughtDetailViewModel: ThoughtDetailViewModelDelegate {
    required init(withThought thought: Thought, _ moc: NSManagedObjectContext) {
        self.moc = moc
        self.thought = thought
        
        print("heights: \(entryHeights)")
    }
    
    // MARK: private vars
    private var moc: NSManagedObjectContext
    
    // MARK: public vars
    public var thoughtPreview: ThoughtPreview { return thought.preview }
    public var entryCount: EntryCount { return thought.entryCount }
    public var thought: Thought
    public var entries: [Entry] {  return thought.allEntries }
    public var entryHeights: [CGFloat] {
        return thought.getHeights(withFont: Device.font.body(ofSize: .large),
                                  andWidth: Device.size.width - 50)
    }
    
    // create new entry for thought
    func buildEntry<T>(payload: T, withLocation location: CLLocation?) where T : EntryBuilder {
        print("creating entry data model")
        _ = Entry.insertEntry(into: moc,
                              location: location,
                              payload: payload,
                              thought: thought)
        save()
    }
    
    func updateThoughtIcon(toIcon icon: ThoughtIcon) {
        print("updating icon")
    }
    
    func delete(entryWithID id: String) {
        print("deleting entry for thought...")
    }
    
    func deleteThought() {
        print("deleting thought")
    }
    
    // call context tot save data
    func save() {
        do {
            try moc.save()
            let count = thought.entryCount
            print("entry save complete in thoughtDetail, entryCount: \(count)")
        } catch let err {
            print(err)
        }
    }
    
    func search(_ payload: String) {
        print("im searching for something!")
    }
}
