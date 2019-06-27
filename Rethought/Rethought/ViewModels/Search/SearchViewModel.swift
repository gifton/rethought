
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
        return collectionView.dequeueReusableCell(withClass: SearchThoughtCell.self, for: indexPath)
    }
    
    func size(forRow: Int) -> CGSize {
        if searchingForEntries == .entry {
            return CGSize(width: (collectionView.frame.width - 20) / 2, height: (collectionView.frame.width - 20) / 2)
        } else {
            return CGSize(width: (collectionView.frame.width), height: 100)
        }
    }
    
    func setSearchEntryType(_ type: SearchType) {
        if type == searchingForEntries { return }
        else { searchingForEntries = type }
        
    }
    
    func search(_ payload: String) {
        
        let predicate = NSPredicate(format: "%K CONTAINS %@", #keyPath(Thought.title.localizedLowercase), payload.lowercased())
        let fetchReq = NSFetchRequest<Thought>(entityName: "Thought")
        fetchReq.predicate = predicate
        
        do {
            try thoughtSearchResults = moc.fetch(fetchReq)
            print("search results recieved: count: \(thoughtSearchResults.count)")
            self.collectionView.reloadData()
            
        } catch {
            print(error)
        }
        
    }
    
    private func find(payload: String, inEntry entry: Entry) -> Bool {
        switch entry.computedEntryType {
        case .photo:
            guard let photo = entry.photo else { print("unable to verify photo in search"); return false }
            guard let detail = photo.detail else { print("unable to verify detail pf photo in search"); return false }
            if detail.lowercased().contains(payload.lowercased()) { return true }
        case .link:
            guard let link = entry.link else { print("unable to verify link in search"); return false }
            if link.title.lowercased().contains(payload.lowercased()) { return true }
            if link.detail.lowercased().contains(payload.lowercased()) { return true }
            if link.url.lowercased().contains(payload.lowercased()) { return true }
        default:
            guard let note = entry.note else { print("unable to verify note in search"); return false }
            if note.title!.lowercased().contains(payload.lowercased()) { return true }
            if note.detail.lowercased().contains(payload.lowercased()) { return true }
        }
        
        
        return false
    }

}
