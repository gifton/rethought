//
//  DashboardController.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData


//Main application view
class DashboardController: UIViewController {
    
    //open var for thoughtCard
    var thoughtCard: ThoughtCardController?
    var dashboard: DashboardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(withContext context: NSManagedObjectContext) {
        super.init(nibName: nil, bundle: nil)
        self.context = context
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: DashboardViewModel! {
        didSet {
            self.thoughts = model.getThoughts()
        }
    }
    var thoughts: [DashboardThought]?
}

extension DashboardController: DashboardDelegate {
    func saveNewThought(_ thought: Thought) {
        let out = model.saveNewThought(thought)
        if out {
            updateInputs()
            self.dashboard?.reloadInputViews()
            self.dashboard?.thoughtCollectionView.reloadData()
        }
    }
    func userStartedNewFastThought() {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = .black
            self.view.layer.opacity = 0.2
        }
    }
    
    func userTapped(on thoughtID: String) {
        print("tapped on \(thoughtID)")
    }
    
    //core data context (set from app delegate)
    var context: NSManagedObjectContext {
        get {
            return model.moc
        }
        set {
            //set view once recieving context, initializing model
            self.model = DashboardViewModel(moc: newValue)
            setupView()
        }
    }
    
    //tought card frame change
    func changeSize(size: ThoughtCardState) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 2.0, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveLinear, animations: {
            switch size {
            case .collapsed:
                self.thoughtCard?.card?.frame = ViewSize.largeBar
            case .cardIsDoneEditing:
                self.thoughtCard?.card?.frame = CGRect(x: 10, y: (ViewSize.SCREEN_HEIGHT - 397) , width: ViewSize.SCREEN_WIDTH - 20, height: 367)
            default:
                self.thoughtCard?.card?.frame = CGRect(x: 5, y: (ViewSize.SCREEN_HEIGHT * 0.184) , width: ViewSize.SCREEN_WIDTH - 10, height: 367)
            }
        })
    }
    
    //after post is saved, reload input values
    func updateInputs() {
        self.thoughts = model.getThoughts()
        self.dashboard?.thoughtCollectionView.reloadData()
        self.dashboard?.thoughtCollectionView.reloadInputViews()
    }
}


extension DashboardController {
    func setupView() {
        guard let thoughts = self.thoughts else { return }
        // add error validation for if there are no thoughts yet
        if thoughts.count > 0 {
            dashboard = DashboardView(delegate: self, frame: .zero)
            dashboard!.thoughtCollectionView.dataSource = self
            dashboard!.thoughtCollectionView.delegate = self
            dashboard!.setupTV()
            self.view = dashboard
        } else {
            dashboard = DashboardView(delegate: self, frame: .zero)
            self.dashboard!.backgroundColor = UIColor(hex: "FAFBFF")
            self.dashboard!.setWithoutDataset()
            self.view = dashboard!
        }
        
        
        //set thoght card
        thoughtCard = ThoughtCardController(withDelegate: self)
        self.addChild(thoughtCard!)
        self.view.insertSubview(thoughtCard!.card!, at: 1000000000)
        thoughtCard!.didMove(toParent: self)
    }
    
    private func checkForUpdates() {
        if self.thoughts?.count ?? 0 > 0 {
            dashboard!.thoughtCollectionView.dataSource = self
            dashboard!.thoughtCollectionView.delegate = self
            self.dashboard!.setupTV()
        }
    }
    
    public func newThoughtSaved() {
        checkForUpdates()
        newThoughtAnimation()
    }
    
    private func newThoughtAnimation() {
        
    }
}

//MARK: collectionView Delegates
extension DashboardController: UICollectionViewDataSource {
    
    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ThoughtFeedHeader", for: indexPath) as! DashboardHeader
        headerView.recentEntries = model.getRecentEntries()
        // Customize headerView here
        return headerView
    }
    
    //count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }

    //cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThoughtCell.identifier, for: indexPath) as! ThoughtCell
        
        guard let thoughts = self.thoughts else { return cell }
        let thought = thoughts[indexPath.row]
        
        cell.giveContext(with: thought)
        
        return cell
    }
    //size
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
extension DashboardController: UICollectionViewDelegate {
    
    //push thought detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let thoughtID: String = self.thoughts?[indexPath.row].thoughtID else { return }
        guard let thought = self.model.retrieve(thought: thoughtID) else  {
            fatalError("unable to retrieve thought from viewmodel")
        }
        
        //set thought detail viewmodel, attach to thoughtDetail
        let vm = ThoughtDetailViewModel(thought: thought, context: self.context)
        let vc = ThoughtDetailController(withThoughtModel: vm)
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    //hide keyboard on scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.resignFirstResponder()
    }
}
