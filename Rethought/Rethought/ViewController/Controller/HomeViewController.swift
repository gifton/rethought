import Foundation
import UIKit

class HomeViewController: UIViewController {

    lazy var viewModel: HomeViewModel = {
        let vm = HomeViewModel(thoughts: self.getDummyDataForReccomededThoughts(8, entryAmount: 8))
        vm.viewDelegate = self
        return vm
    }()
    var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView = HomeView(viewModel.getRecentThoughts(),
                            viewModel.getReccomendedThought(),
                            viewModel.getRecentEntries(),
                            thoughtCount: viewModel.thoughts.count,
                            frame: .zero)
        
        homeView.delegate = self
        view = homeView
        homeView.dataIsLoaded()
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let thoughtCount = self.recentThoughts?.count {
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
        cell.title.text = recentThoughts?[indexPath.row].lastEdited
        cell.emoji.text = recentThoughts?[indexPath.row].icon
        return cell
    }    
}
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidTapThought((recentThoughts?[indexPath.row].thoughtID)!)
    }
}
extension HomeViewController: HomeViewControllerDelegate {
    func dataIsLoaded() {
        self.homeView?.dataIsLoaded()
    }
    
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
    
    func userDidTapThought(_ thoughtID: String) {
        let controller = ThoughtDetailController()
        controller.thought = viewModel.retrieve(thoughtID)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}
