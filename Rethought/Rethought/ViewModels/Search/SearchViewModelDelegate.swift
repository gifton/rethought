
import Foundation
import CoreData
import UIKit

protocol SearchViewModelDelegate {
    func search(_ payload: String)
    func cell(forIndex indexPath: IndexPath) -> UICollectionViewCell
    func size(forRow: Int) -> CGSize
    func setSearchEntryType(_ type: SearchType)
    var searchingForEntries: SearchType { get set }
}
