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

class DashboardController: UIViewController {
    var thoughtCard: ThoughtCardController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var model: DashboardViewModel!
    var thoughts: [DashboardThought]?
}

extension DashboardController: DashboardDelegate {
    
    func userTapped(on thoughtID: String) {
        print("tapped on \(thoughtID)")
    }
    
    var context: NSManagedObjectContext {
        get {
            return model.moc
        }
        set {
            self.model = DashboardViewModel(moc: newValue)
            self.thoughts = model.getThoughts()
            setupView()
        }
    }
    
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
extension DashboardController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThoughtFeedCellTile.identifier, for: indexPath) as! ThoughtFeedCellTile
        
        guard let thoughts = self.thoughts else { return cell }
        let thought = thoughts[indexPath.row]
        
        cell.giveContext(with: thought)
        
        return cell
    }
}
extension DashboardController: UICollectionViewDelegate {
}

extension DashboardController {
    func setupView() {
        guard let thoughts = self.thoughts else { return }
        if thoughts.count > 0 {
            let dashboard = DashboardView(delegate: self, frame: .zero)
            dashboard.thoughtCollectionView.dataSource = self
            dashboard.thoughtCollectionView.delegate = self
            
            self.view = dashboard
        }
        
        thoughtCard = ThoughtCardController()
        thoughtCard?.setCard(delegate: self)
        self.addChild(thoughtCard!)
        self.view.addSubview(thoughtCard!.card!)
        thoughtCard!.didMove(toParent: self)
    }
}
