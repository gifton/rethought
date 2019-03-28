
import Foundation
import UIKit
import CoreData

protocol RootDelegate {
    func showThought(id: String, frame: CGRect)
    func showEntry(ofType entry: EntryType)
}

class RootController: UIViewController {
    
    public var moc: NSManagedObjectContext! {
        didSet {
            buildHeader()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
    }
    
    
    private func buildViewModels(with moc: NSManagedObjectContext) {
        
    }
    
    private func buildHeader() {
        let headerVM = RootHeaderViewModel(moc: moc)
        headerVM.delegate = self
        
        let header = RootHeaderController(with: headerVM)
        header.delegate = self
        
        addChildViewController(header, toContainerView: view)
    }
    
    var num = 0
    
    func extendView(_ inView: UIView) {
        UIView.animate(withDuration: 0.75) {
            if self.num == 0 {
                inView.frame = Device.size.frame
                self.num = 1
            } else {
                inView.frame = CGRect(x: 50, y: 650, width: 100, height: 75)
                self.num = 0
            }
            
        }
        print("tapped!")
    }
    
    func pushVCMain() {
        let newVC = UIViewController()
        newVC.view.backgroundColor = Device.colors.accentGray       
        
        presentPopover(newVC, sourcePoint: CGPoint(x: 175, y: 650), size: CGSize(width: Device.size.width, height: Device.size.height - 20))
    }
}


extension RootController: RootDelegate {
    
    func showThought(id: String, frame: CGRect) {
        let temporaryView = UIView(frame: frame)
        temporaryView.backgroundColor = .white
        temporaryView.layer.cornerRadius = 30
        temporaryView.layer.masksToBounds = true
        view.addSubview(temporaryView)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        
        
        UIView.animate(withDuration: 0.25, animations: {
            temporaryView.frame = Device.size.frame
        }) { (true) in
            temporaryView.removeFromSuperview()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func showEntry(ofType entry: EntryType) {
        let model = EntryListViewModel(with: moc, type: entry)
        
        let vc = EntryListController(ofType: entry, withModel: EntryListViewModel(with: moc, type: <#EntryType#>))
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
