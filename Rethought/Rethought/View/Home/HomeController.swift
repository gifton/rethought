
import Foundation
import UIKit

class HomeController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        // test this
        model.refresh()
        homeHead?.thoughtCollection.reloadData()
        tv?.cv.reloadData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: public vars
    public var animator = ViewAnimator()
    public var model: HomeViewModel! {
        didSet { setView() }
    }
    public var homeHead: HomeHead?
    public var tv: HomeTable?
    lazy var tableButtonMoreView: UIView = UIView()
    
    private func setView() {
        tv = HomeTable(frame: CGRect(x: 0, y: 500, width: Device.size.width, height: Device.size.height - 500))
        tv?.delegate = self
        tv?.cv.dataSource = model
        tv?.animator = self
        tv?.updatepackage(withContent: model.homeContentPackage.title)
        
        homeHead = HomeHead(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: 500))
        homeHead?.thoughtCollection.dataSource = self
        homeHead?.thoughtCollection.delegate = self
        homeHead?.entryPickerView.homeDelegate = self
        
        view.addSubview(homeHead!)
        view.addSubview(tv!)
    }
    
}

// updating views in controller
extension HomeController: Animator {
    
    // updating head view with progress float for calculating animation
    func didUpdate() {
        let progress = tv?.animationProgress ?? 1
        homeHead?.update(toAnimationProgress: progress)
    }
    
    // option view is displayed for specific thoughts or entries
    func show(optionsFor entry: Entry) {
        
        tabBarController?.tabBar.isHidden = true
        let optionView = ShowOptionsView(frame: CGRect(x: 0, y: Device.size.height + 225, width: Device.size.width, height: 225), options: [.delete, .toEntry, .toThought])
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: Device.size.height - optionView.height))
        newView.blurBackground(type: .dark, cornerRadius: 0)
        newView.layer.opacity = 0
        view.addSubview(newView)
        
        self.view.addSubview(optionView)
        let end = {
            optionView.removeFromSuperview()
            newView.removeFromSuperview()
            self.tabBarController?.tabBar.isHidden = false
        }
        
        newView.addTapGestureRecognizer { end() }
        optionView.cancelButton.addTapGestureRecognizer { end() }
        
        // move newView, show blurr over rest of view
        UIView.animate(withDuration: 0.3) {
            optionView.frame.origin.y -= 225 * 2
            newView.layer.opacity = 0.55
        }
    }
    
    // method for registering a view to animnating controller
    func register(_ view: Animatable) {
        animator.register(animatableView: view)
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.thoughtCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ThoughtCollectionCell.self, for: indexPath)
        let preview = model.thoughts[indexPath.row].preview
        cell.addContext(preview ?? .zero)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // get current cell location and animate another view in its position
        let attrs = collectionView.layoutAttributesForItem(at: indexPath)
        let cellFrameInSuperview = collectionView.convert(attrs?.frame ?? .zero, to: collectionView.superview)
        let outModel = model.displayDetail(forThought: model.thoughts[indexPath.row])
        let detail = ThoughtDetailController()
        detail.model = outModel
        
        // create new view and add to superview at cell location
        let newView = UIView(frame: cellFrameInSuperview)
        newView.backgroundColor = .white
        newView.layer.cornerRadius = 30
        view.addSubview(newView)
        
        // animate view down, up, and out
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
            newView.frame.origin.y += 25
        }) { (true) in
            UIView.animate(withDuration: 0.25, animations: {
                newView.frame.origin.y -= 35
                newView.frame = self.view.frame
            }, completion: { (true) in
                self.navigationController?.pushViewController(detail, animated: false)
                newView.removeFromSuperview()
            })
        }
    }
}

extension HomeController: HomeDelegate {
    func show(entryForIndex row: Int) {
        let entryModel = model.retrieve(entry: row)
        let controller = EntryDetailController(withModel: entryModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didSelectEntryType(ofType type: EntryType) {
        model.didSelectEntry(ofType: type) {
            self.tv?.updatepackage(withContent: model.homeContentPackage.title)
            self.tv?.collectionViewCellHeights = model.entryCellHeights
            self.homeHead?.entryPickerView.setSelectedEntry(ofType: type)
            self.tv?.cv.reloadData()
        }
    }
    
    func requestExpansion() {
        model.expanded = true
        tv?.collectionViewCellHeights = model.entryCellHeights
        tv?.cv.reloadData()
        
    }
    func requestCollapse() {
        model.expanded = false
        tv?.collectionViewCellHeights = model.entryCellHeights
        tv?.cv.reloadData()
    }
}

