
import Foundation
import CoreData
import UIKit

protocol SearchViewModelDelegate {
    func search(_ payload: String, completion: () -> ())
    func cell(forIndex indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func size(forRow: Int, tableView: UITableView) -> CGFloat 
    var searchingForEntries: Bool { get set }
}
