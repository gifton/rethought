
import Foundation
import CoreData
import CoreLocation

// handle all logic for showing the home screen
class HomeViewModel: NSObject {
    init(withmoc moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
        setup()
    }
    
    // MARK: private vars
    private var moc: NSManagedObjectContext
    private var currentEntryType: EntryType = .all
    private var filterDirection: FilterDirection = .descending
    // MARK: private mutable string for tableView header
    private var tableTitle: String {
        
        switch currentEntryType {
        case .all: return "All entries \(filterDirection.getString(filterDirection))"
        case .photo: return "Photos \(filterDirection.getString(filterDirection))"
        case .recording: return "Recordings \(filterDirection.getString(filterDirection))"
        case .note: return "Notes \(filterDirection.getString(filterDirection))"
        case .link: return "Links \(filterDirection.getString(filterDirection))"
        default: return "Entries"
        }
    }
    
    // MARK: public vars
    // entry is dependant on thoughts to traverse the relationship
    // less read time to use relationship than make a seperate CD call
    public var entries: [Entry] {
        get { return thoughts.entries() }
    }
    public var thoughtCount: Int {
        get { return self.thoughts.count }
    }
    public var entryCount: Int {
        return entries.count
    }
    public var thoughts: [Thought] = []
    public var homeContentPackage: HomeContentPackage {
        return HomeContentPackage(title: tableTitle, entryType: currentEntryType, filterDirection: filterDirection)
    }
    
    private func setup() {
        thoughts = fetchThoughts()
    }
}

extension HomeViewModel: HomeViewModelDelegate {
    
    func requestDeletion(forthought thought: Thought) {
    print("thought deleted!")
    }
    
    func refresh() {
        thoughts = []
        thoughts = fetchThoughts()
    }
    
    func retrieve(thought id: String) -> Thought? {
        return thoughts.filter{ $0.id == id }.first ?? nil
    }
    
    func retrieve(entry row: Int) -> EntryDetailViewModel {
        let entry = self.entries[row]
        return EntryDetailViewModel(withEntry: entry, moc)
    }
    
    func fetchThoughts() -> [Thought] {
        let request = Thought.sortedFetchRequest
        request.fetchBatchSize = 20
        request.shouldRefreshRefetchedObjects = true
        request.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do { return try moc.fetch(request) } catch let err {
            print("there was an error fetching: \(err)")
        }
        fatalError("fwk")
    }
    
    func displayDetail(forThought thought: Thought) -> ThoughtDetailViewModel {
        return ThoughtDetailViewModel(withThought: thought, moc)
    }
}

extension HomeViewModel {
    func didSelectEntry(ofType type: EntryType, completion: () -> ()) {
        currentEntryType = type
        completion()
    }
    
    func didUpdateFilterDirection(toDirection direction: FilterDirection, completion: () -> ()) {
        filterDirection = direction
        completion()
    }
}
