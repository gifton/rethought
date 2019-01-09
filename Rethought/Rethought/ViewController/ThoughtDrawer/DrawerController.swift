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
    
    //closed objects
    private var iconLabel                 = UILabel()
    private var newThoughtIntro           = UILabel()
    private var timeSinceLastThoughtLabel = UILabel()
    private var nextButton                = DrawerButton()
    //begin thought objs
    private var newThoughtIcon            = DrawerButton()
    private var startThoughtTitleButton   = DrawerButton()
    private var cancelNewThought          = DrawerButton()
    //thought title objs
    private var newThoughtTitleTextView   = ReTextView()
    private var doneButton                = DrawerButton()
    //thought emoji objs
    private var emojiView                 = EmojiView()
    private var newThoughtEmojiDisplay    = EmojiDisplay()
    //completed thought objs
    private var doneWithThoughtButton     = DrawerButton()
    
    //assign each object with a position in the drawer
    //closed obj states
    private var iconLabelDrawerAccess: [DrawerState]                 = DrawerState.allCases
    private var newThoughtIntroDrawerAccess: [DrawerState]           = DrawerState.allCases
    private var timeSinceLastThoughtLabelDrawerAccess: [DrawerState] = DrawerState.allCases
    private var nextButtonDrawerAccess: [DrawerState]                = [.closed, .addEmoji, .addTitle]
    //begin thought obj states
    private var newThoughtIconDrawerAccess: [DrawerState]            = [.beginThought, .addTitle, .continueTheThought]
    private var startThoughtTitleButtonDrawerAccess: [DrawerState]   = [.beginThought, .continueTheThought]
    private var cancelNewThoughtDrawerAccess: [DrawerState]          = [.beginThought]
    //thought title obj states
    private var newThoughtTitleTextViewDrawerAccess: [DrawerState]   = [.beginThought, .addTitle, .continueTheThought]
    private var doneWithTitleButtonDrawerAccess: [DrawerState]       = [.addTitle, .addEmoji]
    //thought emoji obj states
    private var emojiViewDrawerAccess: [DrawerState]                 = [.addEmoji]
    private var newThoughtEmojiDisplayDrawerAccess: [DrawerState]    = [.addEmoji]
    
}
extension DrawerController {
    func createChildren() -> [DrawerObject] {
        //return of function needs to conform to DrawerView view requirements ([DrawerObj])
        var objs: [DrawerObject] = []
        
        //closed thought views
        newThoughtIntro.frame           = CGRect(x: 75, y: 25, width: 150, height: 30)
        iconLabel.frame                 = CGRect(x: 15, y: 25, width: 50, height: 50)
        timeSinceLastThoughtLabel.frame = CGRect(x: 75, y: 60, width: 200, height: 14)
        nextButton.frame                = CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 30, width: 30, height: 30)
        //begin thought views
        newThoughtIcon.frame           = CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 75, width: 45, height: 45)
        startThoughtTitleButton.frame  = CGRect(x: 130, y: 80, width: 175, height: 35)
        cancelNewThought.frame         = CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 30, width: 80, height: 35)

        newThoughtIntro.font           = .reBody(ofSize: 12)
        iconLabel.font                 = .reBody(ofSize: 24)
        timeSinceLastThoughtLabel.font = .reBodyLight(ofSize: 12)
        
        nextButton.setImage(#imageLiteral(resourceName: "arrow-up-border"), for: .normal)
        
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

extension DrawerController: DrawerObjectSource {
    var drawerChildren: [DrawerObject] {
        return createChildren()
    }
}
