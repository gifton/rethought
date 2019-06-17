
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
    public var linkEntries: [Entry] {
        get { return entries.filter {$0.computedEntryType == .link} }
    }
    public var photoEntries: [Entry] {
        get { return entries.filter {$0.computedEntryType == .photo} }
    }
    public var noteEntries: [Entry] {
        get { return entries.filter {$0.computedEntryType == .note} }
    }
    public var recordingEntries: [Entry] {
        get { return entries.filter {$0.computedEntryType == .recording} }
    }
    public var thoughtCount: Int {
        get { return self.thoughts.count }
    }
    public var entryCount: Int {
        switch currentEntryType {
        case .link: return linkEntries.count
        case .photo: return photoEntries.count
        case .note: return noteEntries.count
        case .recording: return recordingEntries.count
        default: return entries.count
        }
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
    
    public func sizeFor(row: Int) -> CGSize {
        
        if !expanded { return CGSize(width: Device.size.width - 20, height: 100) }
        
        let tileSmWidth = (Device.size.width - 50) / 2
        let tileLgWidth = (Device.size.width - 40)
        
        let entry = currentEntry(forRow: row)
        switch entry.computedEntryType {
        case .link, .photo: return CGSize(width: tileSmWidth, height: 188)
        default: return CGSize(width: tileLgWidth, height: entry.heightForContent(width: tileSmWidth))
        }
    }
    
    public var expanded: Bool = false
    private func setup() { thoughts = fetchThoughts() }
    public var homeDelegate: HomeDelegate?
    public var animator: Animator?
    
    private func currentEntry(forRow row: Int) -> Entry {
        switch currentEntryType {
        case .note: return noteEntries[row]
        case .link: return linkEntries[row]
        case .photo: return photoEntries[row]
        case .recording: return recordingEntries[row]
        default: return entries[row]
        }
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
        let currentEntry: Entry = getEntryFor(row: indexPath.row)
        // check if !isExpanded
        // return collapsed cell
        if !expanded {
            let cell = collectionView.dequeueReusableCell(withClass: HomeEntryCell.self, for: indexPath)
            cell.insert(payload: currentEntry)
            guard let animator = animator else { return cell }
            cell.setButtonTargets {
                animator.show(optionsFor: currentEntry)
            }
            return cell
        }
        
        // dequeue proper cell if expanded view
        switch currentEntry.computedEntryType {
        case .link:
            let cell = collectionView.dequeueReusableCell(withClass: HomeLinkTile.self, for: indexPath)
            cell.addContext(currentEntry.associatedBuilder); return cell
        case .photo:
            let cell = collectionView.dequeueReusableCell(withClass: HomePhotoTile.self, for: indexPath)
            guard let builder: PhotoBuilder = currentEntry.associatedBuilder as? PhotoBuilder else { return cell }
            cell.addContext(builder); return cell
        case .recording: return collectionView.dequeueReusableCell(withClass: HomeRecordingTile.self, for: indexPath)
        case .note:
            let cell = collectionView.dequeueReusableCell(withClass: HomeNoteTile.self, for: indexPath)
            cell.addContext(currentEntry.associatedBuilder); return cell
        default:  return nil
        }
        
    }
    
    private func getEntryFor(row: Int) -> Entry {
        switch currentEntryType {
        case .link: return linkEntries[row]
        case .photo: return photoEntries[row]
        case .note: return noteEntries[row]
        case .recording: return recordingEntries[row]
        default: return entries[row]
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
