import Foundation
import UIKit

class HomeViewController: UIViewController {

    lazy var viewModel: HomeViewModel = {
        let vm = HomeViewModel(thoughts: self.recieveDummyData())
        vm.viewDelegate = self
        return vm
    }()
    var homeView: HomeView!
    var thoughtDrawer: ThoughtDrawerController?
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
        
        self.thoughtDrawer = ThoughtDrawerController()
        let thought = viewModel.getMostrecentThought()
        thoughtDrawer?.setupController(self, lastThought: thought)
        
        self.addChild(thoughtDrawer!)
        self.view.addSubview(thoughtDrawer!.view)
        
        thoughtDrawer!.didMove(toParent: self)
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
        let content = recentThoughts![indexPath.row].thoughtID
        delegate?.userDidTapThought(content)
        collectionView.cellForItem(at: indexPath)?.isSelected = false
    }
}
extension HomeViewController: HomeViewControllerDelegate {
    func retrieveTitle(from thoughtID: String) -> String {
        return self.viewModel.getThoughtName(thoughtID)
    }
    
    func dataIsLoaded() {
        self.homeView?.dataIsLoaded()
    }
    
    func userDidTapViewAllThoughts() {
        let view = ThoughtFeedController()
        view.thoughts = self.viewModel.thoughts
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func userDidTapThought(_ thoughtID: String) {
        let controller = ThoughtDetailController()
        controller.thought = viewModel.retrieve(thought: thoughtID)

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func userDidTapOnEntry(_ entryID: String) {
        let vc = EntryDetailController()
        let entry = viewModel.retrieve(entry: entryID)
        vc.entry = entry
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func userTappedNewThought(state: thoughtDrawerHeight) {
        let view = thoughtDrawer!.drawer!
        UIView.animate(withDuration: 0.2) {
            switch state {
            case .closed:
                view.frame = ViewSize.drawerClosed
            case .beginThought:
                view.frame = ViewSize.drawerBeginThought
            case .completeThought:
                view.frame = ViewSize.drawerCompleteThought
            case .isWriting:
                view.frame = ViewSize.drawerIsWriting
            }
        }
    }
    
    func userSavedNewThought(success: Bool) {
        if success {
            print("i didnt have time for an animation lol")
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // -1 to adjust for adding one row on top for the tableView
        switch indexPath.row {
        case 0:
            tableView.cellForRow(at: indexPath)?.isSelected = false
            self.delegate?.userDidTapThought(reccomendedThought!.thoughtID)
        default:
            let row = indexPath.row - 1
            let entry = self.recentEntries![row]
            self.delegate?.userDidTapOnEntry(entry.id)
        }
        tableView.cellForRow(at: indexPath)?.isSelected = false
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
            cell.giveContext(with: reccomendedThought!)
            return cell
        } else {
            let row = indexPath.row - 1
            var entry = self.recentEntries![row]
            let id = entry.ThoughtID
            let title = delegate!.retrieveTitle(from: id)
            entry.ThoughtID = title
            switch entry.type {
            case .image:
                let cell = recentEntryTable.dequeueReusableCell(withIdentifier: ImageEntryCell.identifier, for: indexPath) as! ImageEntryCell
                
                cell.giveContext(with: entry)
                
                return cell
            default:
                let cell = recentEntryTable.dequeueReusableCell(withIdentifier: TextEntryCell.identifier, for: indexPath) as! TextEntryCell
                
                cell.giveContext(with: entry)
                
                return cell
            }
        }
    }
}
