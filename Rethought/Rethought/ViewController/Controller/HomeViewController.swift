import Foundation
import UIKit

class HomeViewController: UIViewController {

    var Thoughts: [Thought]?
    lazy var viewModel: ThoughtViewModel = {
        let vm = ThoughtViewModel(getDummyData(5, entryAmount: 6))
        
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeView = HomeView(viewModel.thoughtList, frame: .zero)
        homeView.profileDelegate = self
        view = homeView
        view.reloadInputViews()
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let thoughtCount = self.thoughts?.count {
            return thoughtCount
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ViewSize.thoughtCellSmall
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recentThoughtsCollectionView.dequeueReusableCell(withReuseIdentifier: RecentThoughtCell.identifier, for: indexPath) as! RecentThoughtCell
        cell.title.text = thoughts?[indexPath.row].title
        return cell
    }    
}
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath.row)
    }
}

extension HomeViewController: ProfileProtocol {
    func userDidPressProfile() {
        print("and here to the profileProtocol!")
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}
