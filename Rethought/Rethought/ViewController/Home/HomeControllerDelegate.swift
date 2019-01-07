//
//  DashboardDelegate.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit



protocol HomeViewControllerDelegate {
    func dataIsLoaded()
    func userDidTapViewAllThoughts()
    func userDidTapThought(_ thoughtID: String)
    func userDidTapOnEntry(_ entryID: String)
    func userTappedNewThought(state: thoughtDrawerHeight)
    func userSavedNewThought(success: Bool)
    func retrieveTitle(from thoughtID: String) -> String
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
