//
//  ThoughtDetailController.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailController: UIViewController{
    fileprivate var detailThought: Thought?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "55AFF8")
    }
}

extension ThoughtDetailController: DetailThoughtDelegate {
    func returnHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    var thought: Thought {
        get {
            return detailThought ?? Thought()
        }
        set {
            let detailView = ThoughtDetailView(frame: .zero, thought: newValue, delegate: self)
            
            self.view = detailView
            
            
        }
    }
    
    
}

protocol DetailThoughtDelegate {
    var thought: Thought { get set }
    func returnHome()
}
