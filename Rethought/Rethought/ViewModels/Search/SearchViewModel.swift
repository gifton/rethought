
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
        // set string to seperated value for looping
        let words = payload.lowercased().components(separatedBy: " ")
        let sorter = NSSortDescriptor(key: "date", ascending: false)
        // get predicates
        let thoughtPredicates = createThoughtPredicate(forPayload: words)
//        var entryPredicates = [NSPredicate]()
        
        
        // create fetch request
        let thoughtFetchReq = NSFetchRequest<Thought>(entityName: "Thought")
        thoughtFetchReq.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: thoughtPredicates)
        thoughtFetchReq.sortDescriptors = [sorter]
        do {
            try thoughtSearchResults = moc.fetch(thoughtFetchReq)
            print("search results recieved: count: \(thoughtSearchResults.count)")
            for thought in thoughtSearchResults {
                print(thought.title)
            }
            self.collectionView.reloadData()
            
        } catch {
            print(error)
        }
        
    }
    
    private func createThoughtPredicate(forPayload payload: [String]) -> [NSPredicate] {
        var predicates = [NSPredicate]()
        for word in payload {
            print("looking for word: \(word)")
            let thoughtTitlePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Thought.title), word)
            let thoughtDatePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Thought.date), word)
            predicates.append(contentsOf: [thoughtTitlePredicate, thoughtDatePredicate])
        }
        print("compiled predicates")
        return predicates
    }

}
