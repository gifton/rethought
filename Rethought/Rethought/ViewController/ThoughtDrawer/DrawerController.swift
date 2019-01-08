//
//  ThoughtDrawerController.swift
//  rethought
//
//  Created by Dev on 1/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import DispatchIntrospection
import ISEmojiView

class DrawerController: UIViewController {
    var drawer: DrawerView?
    var delegate: HomeViewControllerDelegate?
    var viewModel: ThoughtDrawerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("controller loaded")
    }
    
    func setView(delegate: HomeViewControllerDelegate, lastThought: Thought) {
        self.delegate = delegate
        self.viewModel = ThoughtDrawerViewModel(recentThought: lastThought)
        
        self.drawer = DrawerView(frame: ViewSize.drawerIsCollapsed, controller: self, dataSource: createChildren())
        self.view = drawer!
    }
    
    
    //main objects
    public var iconLabel                  = UILabel()
    private var newThoughtIntro           = UILabel()
    private var timeSinceLastThoughtLabel = UILabel()
    private var nextButton                = DrawerButton()
    
    var iconLabelDrawerAccess: [DrawerState] = DrawerState.allCases
    var newThoughtIntroDrawerAccess: [DrawerState] = DrawerState.allCases
    var timeSinceLastThoughtLabelDrawerAccess: [DrawerState] = DrawerState.allCases
    var nextButtonDrawerAccess: [DrawerState] = [.closed, .addEmoji, .addTitle]
}

extension DrawerController: DrawerControllerDelegate {
    func updateState(_ size: DrawerState) {
        switch size {
        case .closed:
            self.delegate?.drawerRequests(state: .collapsed)
        case .beginThought:
            self.delegate?.drawerRequests(state: .mini)
        case .continueTheThought:
            self.delegate?.drawerRequests(state: .medium)
        default:
            self.delegate?.drawerRequests(state: .open)
        }
        
    }
    
    
}

extension DrawerController {
    func createChildren() -> [DrawerObject] {
        var objs: [DrawerObject] = []
        newThoughtIntro.frame           = CGRect(x: 75, y: 25, width: 150, height: 30)
        iconLabel.frame                 = CGRect(x: 15, y: 25, width: 50, height: 50)
        timeSinceLastThoughtLabel.frame = CGRect(x: 75, y: 60, width: 200, height: 14)
        nextButton.frame                = CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 30, width: 30, height: 30)

        newThoughtIntro.font           = .reBody(ofSize: 12)
        iconLabel.font                 = .reBody(ofSize: 24)
        timeSinceLastThoughtLabel.font = .reBodyLight(ofSize: 12)
        
        timeSinceLastThoughtLabel.textColor = .white
        
        nextButton.setImage(#imageLiteral(resourceName: "arrow-up-border"), for: .normal)
//        nextButton.removeTarget(nil, action: nil, for: .allEvents)
        nextButton.nextState = .beginThought
        nextButton.addTarget(self, action: #selector(userTappedUpButton(_:)), for: .touchUpInside)
        
        iconLabel.text = "💭"
        iconLabel.textAlignment = .center
        iconLabel.giveLightBackground()
        
        newThoughtIntro.text = "Whats on your mind?"
        newThoughtIntro.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        newThoughtIntro.giveLightBackground()
        
        let lbls = [iconLabel, newThoughtIntro, timeSinceLastThoughtLabel, nextButton]
        let access = [iconLabelDrawerAccess, newThoughtIntroDrawerAccess, timeSinceLastThoughtLabelDrawerAccess, nextButtonDrawerAccess]
        for (lbl, cred) in zip(lbls, access) {
            objs.append(viewModel!.convertToDrawerObject(lbl, availableIn: cred))
        }
        
        return objs
    }
    
    @objc
    func userTappedUpButton(_ sender: DrawerButton) {
        self.updateState(sender.nextState)
        drawer?.change(state: sender.nextState)
    }
}

extension DrawerController: DrawerObjectSource {
    var drawerChildren: [DrawerObject] {
        return createChildren()
    }
}
