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
                            delegate: self,
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
        let cell = recentThoughtsCollectionView.dequeueReusableCell(withReuseIdentifier: MicroThoughtCell.identifier, for: indexPath) as! MicroThoughtCell
        cell.configureCell(self.recentThoughts![indexPath.row])
        return cell
    }    
}
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidTapThought((recentThoughts?[indexPath.row].thoughtID)!)
    }
}
extension HomeViewController: HomeViewControllerDelegate {
    func userDidTapQuickAddIcon() {
        print ("user wants to look at the icons!")
    }
    
    func userBeganQuickAdd() {
        print ("user began quickAdd!")
    }
    
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

extension HomeView: UITableViewDelegate {
    
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentEntryTable.dequeueReusableCell(withIdentifier: EntryPreviewCell.identifier, for: indexPath) as! EntryPreviewCell
        
        return cell
    }
    
    
}
