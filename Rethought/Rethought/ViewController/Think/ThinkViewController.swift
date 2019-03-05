//
//  ThinkViewController.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThinkViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(model: ThinkViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        
        thinkView = ThinkView(with: self)
        self.view = thinkView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private variables
    var thinkView: ThinkView!
    
    var model: ThinkViewModel!
}

extension ThinkViewController: ThinkDelegate {
    func thoughtComponentsCompleted() {
        print("components completed!")
    }
    
    func createEntry(of type: EntryType) {
        print("creating entry for type: \(type)")
    }
    
    
}
