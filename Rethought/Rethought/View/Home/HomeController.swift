
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
        tv?.updatepackage(withContent: model.homeContentPackage.title)
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
    
    
    // set initial view
    private func setView() {
        // set delegates
        model.homeDelegate = self
        model.animator = self
        
        // set lower bound view
        tv = HomeTable(frame: CGRect(x: 0, y: 500, width: Device.size.width, height: Device.size.height - 500 - Device.size.tabBarHeight))
        tv?.delegate = self
        tv?.cv.dataSource = model
        tv?.animator = self
        tv?.updatepackage(withContent: model.homeContentPackage.title)
        
        // set head bound view
        homeHead = HomeHead(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: 500))
        homeHead?.thoughtCollection.dataSource = self
        homeHead?.thoughtCollection.delegate = self
        homeHead?.entryPickerView.homeDelegate = self
        
        // add to super
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
        let outModel = model.retrieveModelFor(row: indexPath.row)
        
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
                self.showThought(withModel: outModel)
                newView.removeFromSuperview()
            })
        }
    }
}

extension HomeController: HomeDelegate {
    
    func sizeFor(row: Int) -> CGSize {
        return model.sizeFor(row: row)
    }
    
    func didSelectEntryType(ofType type: EntryType) {
        model.didSelectEntry(ofType: type) {
            self.tv?.updatepackage(withContent: model.homeContentPackage.title)
            self.homeHead?.entryPickerView.setSelectedEntry(ofType: type)
            self.tv?.cv.reloadData()
        }
    }
    
    func requestExpansion() {
        model.expanded = true
        tv?.cv.reloadData()
        
    }
    func requestCollapse() {
        model.expanded = false
        tv?.cv.reloadData()
    }
}


// show functions
// show entryDetail
    // by entry
    // by row
// show thoughtDetail
    // by thought
    // by entry
    // by row
// show options
    // by entry
extension HomeController {
    
    // option view is displayed for specific thoughts or entries
    func show(optionsFor entry: Entry) {
        
        // update tabbar
        tabBarController?.tabBar.isHidden = true
        // init optionView
        let optionView = ShowOptionsView(frame: CGRect(x: 0, y: Device.size.height + 225, width: Device.size.width, height: 225),  options: [.delete, .toEntry, .toThought], delegate: self)
        // set models
        let thoughtModel = model.displayDetail(forThought: entry.thought)
        let entryModel = model.retrieveModel(forEntry: entry)
        //create end action
        let end = {
            optionView.removeFromSuperview()
            self.tabBarController?.tabBar.isHidden = false
        }
        //add tap gestures
        optionView.deleteButton.addTapGestureRecognizer { self.model.delete(entry) }
        optionView.toThoughtLabel.addTapGestureRecognizer { self.showThought(withModel: thoughtModel, animated: true)}
        optionView.toEntryLabel.addTapGestureRecognizer { self.show(entry: entry, withModel: entryModel) }
        optionView.cancelButton.addTapGestureRecognizer { end() }
        
        // darken background
        view.darkenBackground { end() }
        
        // add to subview
        self.view.addSubview(optionView)
        // move newView, show blurr over rest of view
        UIView.animate(withDuration: 0.3) {
            optionView.frame.origin.y -= 225 * 2
        }
    }
    
    // entry with index
    func show(entryForIndex row: Int) {
        let entryModel = model.retrieve(entry: row)
        let controller = EntryDetailController(withModel: entryModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // entry from object
    func show(entry: Entry, withModel model: EntryDetailViewModel) {
        let controller = EntryDetailController(withModel: model)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //thought from object
    private func showThought(withModel model: ThoughtDetailViewModel, animated: Bool = false) {
        let detail = ThoughtDetailController()
        detail.model = model
        navigationController?.pushViewController(detail, animated: animated)
    }
}
