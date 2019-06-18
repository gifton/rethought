
import Foundation
import CoreData
import UIKit

protocol SearchViewModelDelegate {
    func search(_ payload: String, completion: () -> ())
    func cell(forRow row: Int, collectionView: UICollectionView) -> UICollectionViewCell?
    func size(forRow: Int, collectionView: UICollectionView) -> CGSize?
    var searchingForEntries: Bool { get set }
}
