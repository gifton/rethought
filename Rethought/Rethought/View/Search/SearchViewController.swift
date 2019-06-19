
import Foundation
import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Device.colors.red
        setView()
    }
    
    public var model: SearchViewModel!
    
    let cv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: Device.size.width - 20, height: 100)
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: Device.size.height - Device.size.tabBarHeight), collectionViewLayout: layout)
        cv.backgroundColor = Device.colors.offWhite
        
        return cv
    }()
    
    func setView() {
        model.collectionView = cv
        view.addSubview(cv)
        
        cv.delegate = self
        cv.dataSource = self
        cv.register(cellWithClass: SearchThoughtCell.self)
        cv.register(cellWithClass: SearchEntryCell.self)
        cv.registerHeaderFooter(cellWithClass: SearchHeadView.self)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.searchCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return model.cell(forIndex: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return model.size(forRow: indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: Device.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head = collectionView.dequeueReusableHeader(cellWithClass: SearchHeadView.self, for: indexPath)
        head.delegate = model
        
        return head
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return model.spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return model.inset
    }
}
