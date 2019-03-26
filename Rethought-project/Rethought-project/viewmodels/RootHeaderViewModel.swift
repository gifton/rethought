import Foundation
import CoreData
import UIKit


protocol RootHeaderViewModelDelegate {
    func search(with keyword: String, completion: () -> Void)
}

class RootHeaderViewModel: NSObject {

    var moc: NSManagedObjectContext!
    var delegate: RootDelegate?
    let dataManager = ModelDataManager()
    
    
    init(moc: NSManagedObjectContext) {
        super.init()
        
        self.moc = moc
        fetchThoughts()
    }
}

extension RootHeaderViewModel: RootHeaderViewModelDelegate {
    func search(with keyword: String, completion: () -> Void) {
        let predicate = NSPredicate(format: "title contains[c] '\(keyword)'")
        let fr = Thought.sortedFetchRequest(with: predicate)
        
        do {
            let output = try moc.fetch(fr)
            dataManager.searchedThoughts(output)
        } catch {
            print("unable to search with given criteria")
        }
        
        completion()
    }

    
    func doneWithSearch() {
        dataManager.isSearching = false
    }
    
    private func fetchThoughts() {
        let request = Thought.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try moc.fetch(request)
            
            dataManager.setThoughts(result)
            
            print("thoughts found... \(result.count)")
        } catch let err {
            print("there was an error fetching: \(err)")
        }
    }
}

// MARK: collectionview data

extension RootHeaderViewModel: UICollectionViewDelegate {}
extension RootHeaderViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("checking count: \(dataManager.count)")
        return dataManager.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRootThoughtCell.identifier, for: indexPath) as! TopRootThoughtCell
        let thought = dataManager.thoughtData[indexPath.row]
        
        cell.addContext(with: thought)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        let cellFrameInSuperview = collectionView.convert(attributes!.frame, to: collectionView.superview)
        delegate?.showThought(id: "6969", frame: cellFrameInSuperview)
    }
}

