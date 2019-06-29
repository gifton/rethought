
import Foundation
import UIKit
import CoreData

enum SearchType: Int {
    case entry = 0
    case thought = 1
}

class SearchViewModel: NSObject {
    init(withMoc moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
    }
    
    // MARK: private vars
    private var moc: NSManagedObjectContext
    private var entrySearchResults = [Entry](){
        didSet {
            collectionView.reloadData()
        }
    }
    private var thoughtSearchResults = [Thought](){
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: public vars
    var searchingForEntries: SearchType = .thought {
        didSet {
            // waity half second to reload to let animations run
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.collectionView.reloadData()
            }
        }
    }
    var collectionView: UICollectionView! {
        didSet {
            collectionView.reloadData()
        }
    }
    var spacing: CGFloat {
        get {
            if searchingForEntries == .entry {
                return 10
            }
            return 0
        }
    }
    var inset: UIEdgeInsets {
        get {
            if searchingForEntries == .entry {
                return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            }
            return .zero
        }
    }
    var searchCount: Int {
        get {
            if searchingForEntries == .entry {
                return entrySearchResults.count
            }
            return thoughtSearchResults.count
        }
    }
}

extension SearchViewModel: SearchViewModelDelegate {
    
    // content for index
    func cell(forIndex indexPath: IndexPath) -> UICollectionViewCell {
        if searchingForEntries == .entry {
            return collectionView.dequeueReusableCell(withClass: SearchEntryCell.self, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withClass: SearchThoughtCell.self, for: indexPath)
        cell.addContext(thoughtPreview(forRow: indexPath.row))
        
        return cell
    }
    
    func size(forRow: Int) -> CGSize {
        if searchingForEntries == .entry {
            return CGSize(width: (collectionView.frame.width - 20) / 2, height: (collectionView.frame.width - 20) / 2)
        } else {
            return CGSize(width: (collectionView.frame.width), height: 100)
        }
    }
    
    func thoughtPreview(forRow row: Int) -> ThoughtPreview {
        let thought = thoughtSearchResults[row]
        return ThoughtPreview(thought: thought)
    }
    
    func setSearchEntryType(_ type: SearchType) {
        if type == searchingForEntries { return }
        else { searchingForEntries = type }
        
    }
    
    func search(_ payload: String) {
        // clear searched entries and thoughts
        entrySearchResults = []
        thoughtSearchResults = []
        // set string to seperated value for looping
        let words = payload.lowercased().components(separatedBy: " ")
        let sorter = NSSortDescriptor(key: "date", ascending: false)
        // get predicates
        let thoughtPredicates = createThoughtPredicate(forPayload: words)
        let photoPredicates = createPredicateForPhoto(withPayload: words)
        let notePredicates = createPredicateForNote(withPayload: words)
        let recordingPredicates = createPredicateForRecording(withPayload: words)
        let linkPredicates = createPredicateForLink(withPayload: words)
        
        // create fetch request
        // thought
        let thoughtFetchReq = NSFetchRequest<Thought>(entityName: "Thought")
        thoughtFetchReq.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: thoughtPredicates)
        thoughtFetchReq.sortDescriptors = [sorter]
        // note
        let noteFetchReq = NSFetchRequest<NoteEntry>(entityName: "NoteEntry")
        noteFetchReq.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: notePredicates)
        // link
        let linkFetchReq = NSFetchRequest<LinkEntry>(entityName: "LinkEntry")
        linkFetchReq.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: linkPredicates)
        //photo
        let photoFetchReq = NSFetchRequest<PhotoEntry>(entityName: "PhotoEntry")
        photoFetchReq.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: photoPredicates)
        // recording
        let recordingFetchReq = NSFetchRequest<NoteEntry>(entityName: "NoteEntry")
        recordingFetchReq.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: recordingPredicates)
        
        // perform fetch
        searchThought(withRequest: thoughtFetchReq)
        searchEntries(withLinkRequest: linkFetchReq)
        searchEntries(withNoteRequest: noteFetchReq)
        searchEntries(withPhotoRequest: photoFetchReq)
        
        print("entries found: \(entrySearchResults.count)")
    }
    
    // fetch thoughts with predicate
    private func searchThought(withRequest req: NSFetchRequest<Thought>) {
        do {
            // preform fetch and set to thought results
            try thoughtSearchResults = moc.fetch(req)
            
            print("search results recieved: count: \(thoughtSearchResults.count)")
            for thought in thoughtSearchResults {
                print(thought.title)
            }
            
        } catch {
            print(error)
        }
    }
    
    private func searchEntries(withLinkRequest req: NSFetchRequest<LinkEntry>) {
        do {
            // get entry content
            let rawEntries = try moc.fetch(req)
            var computedEntries = [Entry]()
            // append entryContents parent entry
            rawEntries.forEach {computedEntries.append($0.entry)}
            // add searched entries to global object holding all searched entries
            self.entrySearchResults.append(contentsOf: computedEntries)
        } catch {
            print(error)
        }
    }
    
    private func searchEntries(withPhotoRequest req: NSFetchRequest<PhotoEntry>) {
        do {
            // get entry content
            let rawEntries = try moc.fetch(req)
            var computedEntries = [Entry]()
            // append entryContents parent entry
            rawEntries.forEach {computedEntries.append($0.entry)}
            // add searched entries to global object holding all searched entries
            self.entrySearchResults.append(contentsOf: computedEntries)
        } catch {
            print(error)
        }
    }
    
    private func searchEntries(withNoteRequest req: NSFetchRequest<NoteEntry>) {
        do {
            // get entry content
            let rawEntries = try moc.fetch(req)
            var computedEntries = [Entry]()
            // append entryContents parent entry
            rawEntries.forEach {computedEntries.append($0.entry)}
            // add searched entries to global object holding all searched entries
            self.entrySearchResults.append(contentsOf: computedEntries)
        } catch {
            print(error)
        }
    }
    
    private func searchEntries(withRecordingRequest req: NSFetchRequest<LinkEntry>) { }
}
