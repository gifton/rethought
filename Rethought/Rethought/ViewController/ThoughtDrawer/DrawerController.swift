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
    private var doneWithTitleButton                = DrawerButton()
    //thought emoji objs
    private var emojiView                 = EmojiView()
    private var newThoughtEmojiDisplay    = EmojiDisplay(frame: CGRect(x: ViewSize.SCREEN_WIDTH - (((ViewSize.SCREEN_WIDTH - 125) / 2) + 125), y: 130, width: 125, height: 125), emoji: ThoughtIcon("🤸🏼‍♂️"))
    //completed thought objs
    private var doneWithThoughtButton     = DrawerButton()
    
    //assign each object with a position in the drawer
    //closed obj states
    private var iconLabelDrawerAccess: [DrawerState]                 = DrawerState.allCases
    private var newThoughtIntroDrawerAccess: [DrawerState]           = DrawerState.allCases
    private var timeSinceLastThoughtLabelDrawerAccess: [DrawerState] = DrawerState.allCases
    private var nextButtonDrawerAccess: [DrawerState]                = [.closed]
    //begin thought obj states
    private var newThoughtIconDrawerAccess: [DrawerState]            = [.beginThought, .addTitle, .continueTheThought]
    private var startThoughtTitleButtonDrawerAccess: [DrawerState]   = [.beginThought, .continueTheThought]
    private var cancelNewThoughtDrawerAccess: [DrawerState]          = [.beginThought]
    //thought title obj states
    private var newThoughtTitleTextViewDrawerAccess: [DrawerState]   = [.addTitle, .continueTheThought]
    private var doneWithTitleButtonDrawerAccess: [DrawerState]       = [.addTitle, .addEmoji]
    //thought emoji obj states
    private var emojiViewDrawerAccess: [DrawerState]                 = [.addEmoji]
    private var newThoughtEmojiDisplayDrawerAccess: [DrawerState]    = [.addEmoji]
    //continue the thought views
    private var doneWithThoughtButtonDrawerAccess: [DrawerState]     = [.continueTheThought]
}
extension DrawerController {
    func createChildren() -> [DrawerObject] {
        //return of function needs to conform to DrawerView view requirements ([DrawerObj])
        var objs: [DrawerObject] = []
        //----------------------------------------------set frame ------------------------------------------------------//
        //closed thought views
        newThoughtIntro.frame           = CGRect(x: 75, y: 25, width: 150, height: 30)
        iconLabel.frame                 = CGRect(x: 15, y: 25, width: 50, height: 50)
        timeSinceLastThoughtLabel.frame = CGRect(x: 75, y: 60, width: 200, height: 14)
        nextButton.frame                = CGRect(x: ViewSize.SCREEN_WIDTH - 50, y: 30, width: 30, height: 30)
        //begin thought views
        newThoughtIcon.frame           = CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 75, width: 45, height: 45)
        startThoughtTitleButton.frame  = CGRect(x: 130, y: 80, width: 175, height: 35)
        cancelNewThought.frame         = CGRect(x: ViewSize.SCREEN_WIDTH - 100, y: 30, width: 80, height: 35)
        //thought title views
        newThoughtTitleTextView.frame  = CGRect(x: 15, y: 85, width: ViewSize.SCREEN_WIDTH - 100, height: 25)
        doneWithTitleButton.frame      = CGRect(x: ViewSize.SCREEN_WIDTH - 100, y: 30, width: 80, height: 35)
        //add emoji views
        //copntinuye the thought views
        newThoughtEmojiDisplay.frame   = CGRect(x: ViewSize.SCREEN_WIDTH - (((ViewSize.SCREEN_WIDTH - 125) / 2) + 125), y: 130, width: 125, height: 125)
        doneWithThoughtButton.frame    = CGRect(x: 20, y: 248, width: ViewSize.SCREEN_WIDTH - 40, height: 35)
        
        //---------------------------------------------style views -----------------------------------------------------//
        //closed thought views
        newThoughtIntro.padding        = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        iconLabel.layer.cornerRadius   = 6
        iconLabel.layer.masksToBounds  = true
        iconLabel.textAlignment        = .center
        newThoughtIntro.giveDarkBackground()
        iconLabel.giveDarkBackground()
        //begin thought views
        newThoughtIcon.layer.cornerRadius          = 6
        newThoughtIcon.layer.masksToBounds         = true
        startThoughtTitleButton.backgroundColor    = UIColor(hex: "6271fc")
        startThoughtTitleButton.layer.cornerRadius = 5
        cancelNewThought.backgroundColor           = UIColor(hex: "E3C050")
        cancelNewThought.layer.cornerRadius        = 5
        cancelNewThought.layer.masksToBounds       = true
        newThoughtIcon.giveLightBackground()
        //thought title views
        newThoughtTitleTextView.backgroundColor     = UIColor(hex: "384CBC")
        newThoughtTitleTextView.layer.cornerRadius  = 5
        newThoughtTitleTextView.layer.masksToBounds = true
        newThoughtTitleTextView.font                = .reBody(ofSize: 12)
        doneWithTitleButton.backgroundColor         = UIColor(hex: "51DF9F")
        doneWithTitleButton.layer.cornerRadius      = 5
        newThoughtTitleTextView.giveLightBackground()
        //add emoji view
        
        //--------------------------------------------- add context ----------------------------------------------------//
        //closed views
        let view = UIView()
        iconLabel.addText(size: 24, font: .body, string: "💭")
        newThoughtIntro.addText(color: .white, size: 12, font: .body, string: "Whats on your mind?")
        timeSinceLastThoughtLabel.addText(color: .white, size: 12, font: .bodyLight, string: self.viewModel!.buildRecent())
        nextButton.setImage(#imageLiteral(resourceName: "arrow-up-border"), for: .normal)
        //begin thought views
        newThoughtIcon.setTitle("🔀", for: .normal)
        startThoughtTitleButton.setAttributedTitle(view.addAttributedText(size: fontSize.small.rawValue, font: .body, string: "Type a brief description"), for: .normal)
        cancelNewThought.setAttributedTitle(view.addAttributedText(size: fontSize.small.rawValue, font: .body, string: "cancel"), for: .normal)
        //add title views
        newThoughtTitleTextView.placeholder = "Start Here"
        doneWithTitleButton.setAttributedTitle(view.addAttributedText(size: fontSize.small.rawValue, font: .body, string: "done"), for: .normal)
        //add emoji views
        newThoughtEmojiDisplay.emoji = ThoughtIcon("🌋")
        
        //--------------------------------------------- add targets ----------------------------------------------------//
        nextButton.nextState = .beginThought
        nextButton.addTarget(self, action: #selector(userTappedUpButton(_:)), for: .touchUpInside)
        
        startThoughtTitleButton.nextState = .addTitle
        startThoughtTitleButton.addTarget(self, action: #selector(userTappedUpButton(_:)), for: .touchUpInside)
        
        newThoughtIcon.nextState = .addEmoji
        newThoughtIcon.addTarget(self, action: #selector(userTappedUpButton(_:)), for: .touchUpInside)
        
        cancelNewThought.nextState = .closed
        cancelNewThought.addTarget(self, action: #selector(userTappedUpButton(_:)), for: .touchUpInside)
        
        doneWithTitleButton.nextState = .beginThought
        doneWithTitleButton.addTarget(self, action: #selector(userTappedUpButton(_:)), for: .touchUpInside)
        
        doneWithThoughtButton.nextState = .closed
        doneWithThoughtButton.addTarget(self, action: #selector(userTappedUpButton(_:)), for: .touchUpInside)
        
        let objects = [iconLabel, newThoughtIntro, timeSinceLastThoughtLabel, nextButton, newThoughtIcon, startThoughtTitleButton, cancelNewThought, newThoughtTitleTextView, doneWithTitleButton, newThoughtEmojiDisplay, doneWithThoughtButton]
        let objectAccess = [iconLabelDrawerAccess, newThoughtIntroDrawerAccess, timeSinceLastThoughtLabelDrawerAccess, nextButtonDrawerAccess, newThoughtIconDrawerAccess, startThoughtTitleButtonDrawerAccess, cancelNewThoughtDrawerAccess, newThoughtTitleTextViewDrawerAccess, doneWithTitleButtonDrawerAccess, newThoughtEmojiDisplayDrawerAccess, doneWithThoughtButtonDrawerAccess]
        
        for (obj, acc) in zip(objects, objectAccess) {
            objs.append(viewModel!.convertToDrawerObject(obj, availableIn: acc))
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
