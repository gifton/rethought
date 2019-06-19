
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
    private var entrySearchResultss = [Entry]()
    private var thoughtSearchResultss = [Thought]()
    
    var searchingForEntries: Bool = true
}

extension SearchViewModel: SearchViewModelDelegate {
    
    func search(_ payload: String, completion: () -> ()) {
        
    }

    func cell(forIndex indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCell(withClass: SearchThoughtCell.self, for: indexPath)
    }

    func size(forRow: Int, tableView: UITableView) -> CGFloat {
        return 100
    }

}
