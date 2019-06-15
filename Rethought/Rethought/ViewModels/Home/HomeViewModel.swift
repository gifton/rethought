
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
    // MARK: private mutable string for tableView header
    private var tableTitle: String {
        
        switch currentEntryType {
        case .all: return "All entries"
        case .photo: return "Photos"
        case .recording: return "Recordings"
        case .note: return "Notes"
        case .link: return "Links"
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
        case .photo: return (Device.size.width - 20) / 2
        default: return Device.size.width - 20
        }
    }
    public var homeContentPackage: HomeContentPackage {
        return HomeContentPackage(title: tableTitle, entryType: currentEntryType)
    }
    public var entryCellHeights: [CGSize] {
        var heights = [CGSize]()
        
        if expanded {
            
            for entry in entries {
                switch entry.computedEntryType {
                case .link, .photo: heights.append(CGSize(width: (Device.size.width - 80) / 2, height: 188))
                case .note:
                    let newHeight = entry.heightForContent(width: Device.size.width - 40)
                    heights.append(CGSize(width: Device.size.width - 40, height: newHeight))
                default: heights.append(CGSize(width: Device.size.width - 20, height: 100))
                }
            }
            
        } else {
            heights = Array(repeating: CGSize(width: Device.size.width - 20, height: 100), count: entryCount)
        }
        
        return heights
    }
    public var expanded: Bool = false
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
    
    func cellFor(indexPath: IndexPath, withCollectionView collectionView: UICollectionView) -> UICollectionViewCell? {
        // get current entry
        let currentEntry = entries[indexPath.row]
//        print("captured current entry of type: \(currentEntry.type) in view model cellFor() method")
        // check if !isExpanded
        if !expanded {
            let cell = collectionView.dequeueReusableCell(withClass: HomeEntryCell.self, for: indexPath)
            cell.insert(payload: currentEntry)
            return cell
        }
        
        // dequeue proper cell
        switch currentEntry.computedEntryType {
        case .link: return collectionView.dequeueReusableCell(withClass: HomeLinkTile.self, for: indexPath)
        case .photo: return collectionView.dequeueReusableCell(withClass: HomePhotoTile.self, for: indexPath)
        case .recording: return collectionView.dequeueReusableCell(withClass: HomeRecordingTile.self, for: indexPath)
        case .note: return collectionView.dequeueReusableCell(withClass: HomeNoteTile.self, for: indexPath)
        default:  return nil
        }
        
    }
}


extension HomeViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cellFor(indexPath: indexPath, withCollectionView: collectionView) else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entryCount
    }
}
