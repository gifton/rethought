
import Foundation
import CoreData
import CoreLocation
import UIKit

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
    private var links: [Entry] {
        return entries.filter {$0.computedEntryType == .link}
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
    public var entryCellWidth: CGFloat {
        switch currentEntryType {
        case .photo: return (Device.size.width - 40) / 2
        default: return Device.size.width - 20
        }
    }
    public var homeContentPackage: HomeContentPackage {
        return HomeContentPackage(title: tableTitle, entryType: currentEntryType, filterDirection: filterDirection)
    }
    public var entryCellHeights: [CGSize] {
        var heights = [CGSize]()
        
        for (index, entry) in entries.enumerated() {
            switch entry.computedEntryType {
            default: heights.append(CGSize(width: Device.size.width - 20, height: 100))
            }
        }
        
        return heights
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
    
    func cellFor(row: Int) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}


extension HomeViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HomeEntryCell.self, for: indexPath)
        
        cell.insert(payload: entries[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entryCount
    }
}
