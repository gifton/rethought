//
//  TopRootController.swift
//  Rethought-project
//
//  Created by Dev on 3/18/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol RootHeaderDelegate {
    func reload()
    func showEntry(ofType type: EntryType)
}

class RootHeaderController: UIViewController {
    var rootView: RootHeaderView!
    var delegate: RootDelegate?
    var model:    RootHeaderViewModel!
    
    init(with model: RootHeaderViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        
        //set view
        rootView = RootHeaderView(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: Device.size.height * 0.43))
        rootView.thoughtCollection.delegate = self.model
        rootView.thoughtCollection.dataSource = self.model
        rootView.searchBar.delegate = self
        rootView.entryCollection.rootHeaderDelegate = self
        
        view = rootView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RootHeaderController: RootHeaderDelegate {
    func reload() {
        rootView.thoughtCollection.reloadData {
            print("data reloaded")
        }
    }
}

extension RootHeaderController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            model.doneWithSearch()
        } else {
            model.search(with: searchBar.text!) {
                reload()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel button clicked")
        self.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        model.doneWithSearch()
        reload()
    }
    
    func showEntry(ofType type: EntryType) {
        delegate?.showEntry(ofType: type)
    }
}


