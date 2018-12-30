//
//  ThoughtFeedController.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


class ThoughtFeedController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBlue
    }
    
    //private vars
    public var viewModel: ThoughtFeedViewModel?
}

extension ThoughtFeedController: ThoughtFeedDelegate {
    
    func userTapped(on thought: Thought) {
        let view = ThoughtDetailController()
        view.thought = thought
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func returnHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public var thoughts: [Thought] {
        get {
            return (self.viewModel?.thoughts)!
        }
        set {
            viewModel = ThoughtFeedViewModel(thoughts: newValue)
            let newView = ThoughtFeedView(frame: ViewSize.FRAME)
            newView.delegate = self
            newView.thoughtCollectionView.delegate = self
            newView.thoughtCollectionView.dataSource = self
            
            self.view = newView
        }
    }
    
    
}

extension ThoughtFeedController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (viewModel?.getThoughtName(thoughts[indexPath.row].ID) as Any)
        let vc = ThoughtDetailController()
        guard let viewModel = self.viewModel else { return }
        vc.thought = viewModel.thoughts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ThoughtFeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThoughtFeedCellTile.identifier, for: indexPath) as! ThoughtFeedCellTile
        cell.backgroundColor = UIColor(hex: "F5F5F9")
        cell.giveContext(with: (viewModel?.retrieveThoughtPreview(thoughts[indexPath.row].ID))!)
        return cell
    }
    
    
}
