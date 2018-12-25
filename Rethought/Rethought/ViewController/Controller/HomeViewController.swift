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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 185
        } else {
            // -1 to adjust for adding one row on top for the tableView
            let row = indexPath.row - 1
            if let img = self.recentEntries![row].images.first {
                return img.size.height
            } else {
                return 101
            }
        }
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.recentEntries?.count {
            //add one for recommendedThoughtCell at index == 0
            return count + 1
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = recentEntryTable.dequeueReusableCell(withIdentifier: RecommendedThoughtCell.identifier, for: indexPath) as! RecommendedThoughtCell
            cell.giveContext(reccomendedThought!)
            return cell
        } else {
            let row = indexPath.row - 1
            let entry = self.recentEntries![row]
            switch entry.type {
            case .image:
                let cell = recentEntryTable.dequeueReusableCell(withIdentifier: ImageEntryCell.identifier, for: indexPath) as! ImageEntryCell
                
                cell.giveContext(entry)
                
                return cell
            default:
                let cell = recentEntryTable.dequeueReusableCell(withIdentifier: TextEntryCell.identifier, for: indexPath) as! TextEntryCell
                
                cell.giveContext(entry)
                
                return cell
            }
        }
    }
}
