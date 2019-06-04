
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
        return thought.getHeights(andWidth: Device.size.width - 50).reversed()
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

// serving model data to tableView
extension ThoughtDetailViewModel {
    func cellFor(index: IndexPath, tableView: UITableView) -> UITableViewCell?  {
        switch index.row {
        case 0: return tableView.dequeueReusableCell(withClass: ThoughtDetailTableHead.self, for: index)
        default:
            let type = entries[index.row].computedEntryType
            switch type {
            case .link:
                let cell = tableView.dequeueReusableCell(withClass: LinkEntryCell.self, for: index)
                guard let link = entries[index.row].link else { return cell }
                let builder = LinkBuilder(withEntry: link)
                cell.add(content: builder)
                return cell
            case .note:
                // create cell
                let cell = tableView.dequeueReusableCell(withClass: NoteEntryCell.self, for: index)
                // guard entry object
                guard let note = entries[index.row].note else { return cell }
                let builder = NoteBuilder(withNote: note)
                // add builder into cell
                cell.add(context: builder)
                return cell
            case .recording: return UITableViewCell()
            case .photo: return UITableViewCell()
            default: return UITableViewCell()
            }
        }
    }
    
    func heightFor(row: Int) -> CGFloat {
        if row == 0 {
            return 300
        }
        
        let currentEntry = entries[row]
        let height = currentEntry.heightForContent(width: Device.size.width - 70)
        print(currentEntry.type, ": \(height)")
        return height
    }
}
