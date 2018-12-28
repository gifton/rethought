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
    
    public func addContext(with thoughtPreviews: [ThoughtPreviewLarge]) {
        
    }
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
    
    var thoughtPreviews: ThoughtPreviewLarge {
        get {
            return thoughtPreviews
        }
        set {
            thoughtPreviews = newValue
            self.viewModel = ThoughtFeedViewModel(thoughts: <#T##[Thought]#>)
        }
    }
    
    
}
