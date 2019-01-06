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
    
    public func setupController(_ delegate: HomeViewControllerDelegate) {
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var drawer: ThoughtDrawerView?
    private var delegate: HomeViewControllerDelegate?
}

extension ThoughtDrawerController: NewThoughtDelegate {
    func save(_ thought: Thought) {
        print("saved contezt: \(thought.title)")
    }
    
    var thoughtState: thoughtDrawerHeight {
        get {
            return drawer!.state
        }
        set {
         delegate?.userTappedNewThought(state: newValue)
        }
    }
}
