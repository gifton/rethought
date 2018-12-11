import Foundation
import UIKit

class HomeViewController: UIViewController {

    var Thoughts: [Thought]?
    lazy var viewModel: ThoughtViewModel = {
        let vm = ThoughtViewModel(getDummyDataForReccomededThoughts(5, entryAmount: 5))
        
        return vm
    }()
    var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeView = HomeView(viewModel.thoughtList, frame: .zero)
        homeView.delegate = self
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
        cell.emoji.text = thoughts?[indexPath.row].icon
        return cell
    }    
}
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidTapThought((thoughts?[indexPath.row])!)
    }
}

extension HomeViewController: DashboardDelegate {
    func userDidTapProfileButton() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func userDidTapViewAllThoughts() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func userDidTapViewAllEntries() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func userDidTapNewThought() {
        self.navigationController?.pushViewController(NewThoughtController(), animated: true)
    }
    
    func userDidTapThought(_ thought: Thought) {
        let controller = ThoughtDetailController()
        controller.thought = thought
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}
