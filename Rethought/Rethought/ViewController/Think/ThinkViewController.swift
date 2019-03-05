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
        self.view.backgroundColor = .white
    }
    
    init(model: ThinkViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        
        thinkView = ThinkView(with: self)
        thinkView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(thinkView)
        thinkView.setAnchor(top: view.safeTopAnchor, leading: view.leadingAnchor, bottom: view.safeBottomAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
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
    
    func showKeyboard() {
        for view in thinkView.subviews {
            view.frame.origin.y -= 250
        }
    }
    func hideKeyboard() {
        for view in thinkView.subviews {
            view.frame.origin.y += 250
        }
    }
}
