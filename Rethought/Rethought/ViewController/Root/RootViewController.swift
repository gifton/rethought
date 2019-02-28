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
    
    lazy var searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rootView = RootView()
        view = rootView
        searchBar.placeholder = "Search!"
        searchBar.sizeToFit()
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        self.title = "Rethought"
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 100)
    }
}
