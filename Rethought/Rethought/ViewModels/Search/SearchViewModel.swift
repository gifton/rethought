
import Foundation
import UIKit
import CoreData

class SearchViewModel: NSObject {
    init(withMoc moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
    }
    
    // MARK: private vars
    private var moc: NSManagedObjectContext
    private var entrySearchResultss = [Entry]()
    private var thoughtSearchResultss = [Thought]()
    
    var searchingForEntries: Bool = true
}

//extension SearchViewModel: SearchViewModelDelegate {
//    func search(_ payload: String, completion: () -> ()) {
//        let myRequest = NSFetchRequest(entityName: "entity")
//        myRequest.predicate = NSPredicate(format: "name = %@", "David")
//    }
//
//    func cell(forRow row: Int, collectionView: UICollectionView) -> UICollectionViewCell? {
//        <#code#>
//    }
//
//    func size(forRow: Int, collectionView: UICollectionView) -> CGSize? {
//        <#code#>
//    }
//
//}
