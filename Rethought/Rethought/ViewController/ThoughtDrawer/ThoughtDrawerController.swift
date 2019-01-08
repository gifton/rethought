//
//  ThoughtDrawerController.swift
//  rethought
//
//  Created by Dev on 1/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDrawerController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var viewModel: ThoughtDrawerViewModel?
    
    public func setupController(_ delegate: HomeViewControllerDelegate, lastThought: Thought) {
        self.delegate = delegate
        self.viewModel = ThoughtDrawerViewModel(recentThought: lastThought)
        self.drawer = ThoughtDrawerView(frame: ViewSize.drawerClosed, lastThought: (viewModel?.buildRecent(string: lastThought.lastEdited))!, delegate: self)
        self.view = drawer
    }
    
    var drawer: ThoughtDrawerView?
    var delegate: HomeViewControllerDelegate?
}

class ThoughtDrawer: UIViewController {
    var drawer: DrawerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    public func buildDrawer(delegate: HomeViewControllerDelegate) {
        drawer = DrawerView(frame: ViewSize.drawerClosed)
        drawer?.updateSize = delegate
        self.view = drawer!
    }
    
    
}
