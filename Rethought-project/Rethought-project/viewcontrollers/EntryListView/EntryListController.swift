

import Foundation
import UIKit

protocol EntryListDelegate {
    func show(thoughtID: String)
    func search(with key: String)
}
class EntryListController: UIViewController {
    var listView: EntryListView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Device.colors.darkText
    }
    
    // MARK: Private
    private var model: EntryListViewModel
    private var type: EntryType {
        get {
            return model.entryType
        }
        set {
            model.entryType = newValue
        }
    }
    
    //initiate with:
    // - type of entry
    // - EntryList ViewModel
    init(ofType type: EntryType, withModel model: EntryListViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.type = type
        
        let header = EntryListHeader(ofType: type, entryCount: model.count, locationCount: 3)
        listView = EntryListView(header: header)
        
        
        view = listView
        connectView()
    }
    
    //inject required delegates and datasources
    private func connectView() {
        if (listView != nil) {
            listView!.backBtn.addTarget(self, action: #selector(returnHome(_:)), for: .touchUpInside)
            listView!.searchBar.delegate = self
            listView!.tableView.dataSource = model
            listView!.tableView.delegate = model
        } else {
            print("listView not confirmed initialized")
            let header = EntryListHeader(ofType: .all, entryCount: 0, locationCount: 0)
            listView = EntryListView(header: header)
            
            view = listView!
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func returnHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension EntryListController: EntryListDelegate {
    
    //display thoughtDetail of tapped entry
    func show(thoughtID: String) {
        print("showing thoughts!")
    }
    
    //update tableview with searched entries from core data
    func search(with key: String) {
        print("showing search!")
    }
}

extension EntryListController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            model.doneWithSearch()
        } else {
            model.search(with: searchBar.text!) {
                listView?.tableView.reloadData {
                    print("reloaded data")
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel button clicked")
        self.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        model.doneWithSearch()
        listView?.tableView.reloadData {
            print("reloaded data")
        }
    }
}
