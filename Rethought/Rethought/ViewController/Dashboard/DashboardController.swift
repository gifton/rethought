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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var model: DashboardViewModel!
    var thoughts: [DashboardThought]?
}

extension DashboardController: DashboardDelegate {
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
            self.thoughts = model.getThoughts()
            setupView()
        }
    }
    
    //tought card frame change
    func changeSize(size: ThoughtCardState) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 2.0, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveLinear, animations: {
            switch size {
            case .collapsed:
                self.thoughtCard?.card?.frame = CGRect(x: 10, y: ViewSize.SCREEN_HEIGHT * 0.87, width: ViewSize.SCREEN_WIDTH - 20, height: 69)
            case .cardIsDoneEditing:
                self.thoughtCard?.card?.frame = CGRect(x: 10, y: (ViewSize.SCREEN_HEIGHT - 397) , width: ViewSize.SCREEN_WIDTH - 20, height: 367)
            default:
                self.thoughtCard?.card?.frame = CGRect(x: 10, y: (ViewSize.SCREEN_HEIGHT * 0.184) , width: ViewSize.SCREEN_WIDTH - 20, height: 367)
            }
        }) { (true) in }
    }
}


extension DashboardController {
    func setupView() {
        guard let thoughts = self.thoughts else { return }
        // add error validation for if there are no thoughts yet
        if thoughts.count > 0 {
            let dashboard = DashboardView(delegate: self, frame: .zero)
            dashboard.thoughtCollectionView.dataSource = self
            dashboard.thoughtCollectionView.delegate = self
            self.view = dashboard
        }
        
        //set thoght card
        thoughtCard = ThoughtCardController()
        thoughtCard?.setCard(delegate: self)
        self.addChild(thoughtCard!)
        self.view.addSubview(thoughtCard!.card!)
        thoughtCard!.didMove(toParent: self)
    }
}

//MARK: collectionView Delegates
extension DashboardController: UICollectionViewDataSource {
    
    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ThoughtFeedCellTile", for: indexPath) as! DashboardHeader
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThoughtFeedCellTile.identifier, for: indexPath) as! ThoughtFeedCellTile
        
        guard let thoughts = self.thoughts else { return cell }
        let thought = thoughts[indexPath.row]
        
        cell.giveContext(with: thought)
        
        return cell
    }
    //display new Thoght
    func userTapped(on thought: Thought) {
        let view = ThoughtDetailController()
        view.thought = thought
        self.navigationController?.pushViewController(view, animated: true)
    }
}
extension DashboardController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //hide keyboard on scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.resignFirstResponder()
    }
}
