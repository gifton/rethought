//
//  RootViewController.swift
//  rethought
//
//  Created by Dev on 2/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    var searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rethought"
    }
    
    var model: RootViewModel! {
        didSet {
            let rootView = RootView()
            rootView.model = model
            self.view = rootView
        }
    }
    
    init(with model: RootViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewDidLoad()
        let view = RootView(frame: .zero)
        view.model = model
        self.view = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
