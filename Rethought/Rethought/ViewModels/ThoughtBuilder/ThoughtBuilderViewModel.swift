
import Foundation
import CoreData
import CoreLocation

class ThoughtBuilderViewModel: NSObject {
    init(withContext context: NSManagedObjectContext) {
        self.moc = context
        do {
            let count = try context.count(for: Thought.fetchRequest())
            print("builder initiated, thoughtCount: \(count)")
        } catch {
            print(error)
        }
        
        
    }
    
    private var moc: NSManagedObjectContext
    private var currentThoughtPreview: ThoughtPreview?
    private var currentThought: Thought? {
        guard let tp: ThoughtPreview = currentThoughtPreview else {
            return nil
        }
        return Thought.insert(in: moc, withPreview: tp)
    }
}


extension ThoughtBuilderViewModel: ThoughtBuilderViewModelDelegate {
    
    
    func save() {
        do {
            try moc.save()
            do {
                let count = try self.moc.count(for: Thought.fetchRequest())
                print("save complete, thoughtCount: \(count)")
            } catch {
                print(error)
            }
        } catch let err {
            print(err)
        }
    }
    
    func buildThought(withTitle title: String, withLocation location: CLLocation?, withIcon icon: ThoughtIcon) -> ThoughtPreview {
        print("building thoughtprview from thoughtBuilderViewModel")
        currentThoughtPreview = ThoughtPreview(title: title, icon: icon.icon, location: location)
        setThoughtToDB()
        save()
        return currentThoughtPreview!
    }
    
    func buildEntry<T>(payload: T, withLocation location: CLLocation?) where T : EntryBuilder {
        guard let thought = currentThought else {
            print("unable to verify current thought model, returning")
            return
        }
        print("creating entry data model")
        _ = Entry.insertEntry(into: moc,
                                         location: location,
                                         payload: payload,
                                         thought: thought)
        save()
    }
    
    func updateThoughtIcon(toIcon icon: ThoughtIcon) {
        guard let currentThought = currentThought else { return }
        
        currentThought.icon = icon.icon
        save()
    }
    
    private func setThoughtToDB() {
        guard let currentThought = currentThoughtPreview else {
            print("unable to verify thought preview when creating model object")
            return
        }
        _ = Thought.insert(in: moc, withPreview: currentThought)
        save()
    }
}
