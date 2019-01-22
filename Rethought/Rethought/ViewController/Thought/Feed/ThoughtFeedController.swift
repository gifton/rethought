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
            guard let vm = self.viewModel else { return [Thought()]}
            return (vm.allThoughts)
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
        let vc = ThoughtDetailController()
        
        guard let viewModel = self.viewModel else { return }
        
        vc.thought = viewModel.allThoughts[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ThoughtFeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThoughtFeedCellTile.identifier, for: indexPath) as! ThoughtFeedCellTile
        
        guard let vm = self.viewModel else { return cell }
        let id = self.thoughts[indexPath.row].ID
        
        cell.giveContext(with: (vm.retrieveThoughtPreview(id)))
        
        return cell
    }
    
    
}
