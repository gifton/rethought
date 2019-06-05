
import Foundation
import UIKit
import CoreData
import CoreLocation

// handle Thought Detail logic
class ThoughtDetailViewModel: ThoughtDetailViewModelDelegate {
    required init(withThought thought: Thought, _ moc: NSManagedObjectContext) {
        self.moc = moc
        self.thought = thought
        
        for entry in entries {
            print(entry.type)
        }
    }
    
    // MARK: private vars
    private var moc: NSManagedObjectContext
    public var isSearching: Bool = false
    
    // MARK: public vars
    public var thoughtPreview: ThoughtPreview { return thought.preview }
    public var entryCount: EntryCount { return thought.entryCount }
    public var tableCount: Int {
        if isSearching { return searchedEntries.count}
        return entries.count
    }
    public var thought: Thought
    public var entries: [Entry] {
        if isSearching { return searchedEntries }
        return thought.allEntries
    }
    private var searchedEntries = [Entry]()
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
    
    func search(_ payload: String, completion: () -> ()) {
        print("searching from model")
        for ent in entries {
            print("entry being searched: \(ent.id)")
            if find(payload: payload, inEntry: ent) {
                print("adding entry to model: \(ent.id)")
                searchedEntries.append(ent)
            }
        }
        print(searchedEntries.count)
        isSearching = true
        completion()
    }
    func doneSearching(completion: () -> ()) {
        print("confirmed from model searching is complete")
        isSearching = false
        completion()
    }
    
    private func find(payload: String, inEntry entry: Entry) -> Bool {
        switch entry.computedEntryType {
        case .photo:
            guard let photo = entry.photo else { print("unable to verify photo in search"); return false }
            guard let detail = photo.detail else { print("unable to verify detail pf photo in search"); return false }
            if detail.contains(payload) { return true }
        case .link:
            guard let link = entry.link else { print("unable to verify link in search"); return false }
            if link.title.contains(payload) { return true }
            if link.detail.contains(payload) { return true }
            if link.url.contains(payload) { return true }
        default:
            guard let note = entry.note else { print("unable to verify note in search"); return false }
            if note.title!.contains(payload) { return true }
            if note.detail.contains(payload) { return true }
        }
        
        
        return false
    }
}

// serving model data to tableView
extension ThoughtDetailViewModel {
    func cellFor(index: IndexPath, tableView: UITableView) -> UITableViewCell?  {
        switch index.row {
        case 0: return tableView.dequeueReusableCell(withClass: ThoughtDetailTableHead.self, for: index)
        default:
            let row = index.row - 1
            let type = entries[row].computedEntryType
            switch type {
            case .link:
                let cell = tableView.dequeueReusableCell(withClass: LinkEntryCell.self, for: index)
                guard let link = entries[row].link else { return cell }
                let builder = LinkBuilder(withEntry: link)
                cell.add(content: builder)
                return cell
            case .note:
                // create cell
                let cell = tableView.dequeueReusableCell(withClass: NoteEntryCell.self, for: index)
                // guard entry object
                guard let note = entries[row].note else { return cell }
                let builder = NoteBuilder(withNote: note)
                // add builder into cell
                cell.add(context: builder)
                return cell
            case .recording: return UITableViewCell()
            case .photo:
                // create cell
                let cell = tableView.dequeueReusableCell(withClass: PhotoEntryCell.self, for: index)
                // guard entry object
                guard let photo = entries[row].photo else {
                    print("couldnt get photo")
                    return cell
                }
                let builder = PhotoBuilder(withEntry: photo, forWidth: Device.size.width - 20)
                // add builder into cell
                cell.add(context: builder)
                return cell
            default: return UITableViewCell()
            }
        }
    }
    
    func searchEntriesFor(payload: String) {
        
    }
    
    func heightFor(row: Int) -> CGFloat {
        if row == 0 {
            return 300
        }
        
        let currentEntry = entries[row - 1]
        let height = currentEntry.heightForContent(width: Device.size.width - 70)
        return height
    }
}
