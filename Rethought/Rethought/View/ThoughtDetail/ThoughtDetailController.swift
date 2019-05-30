//
//  ThoughtDetailController.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addTapGestureRecognizer {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    lazy var headView = ThoughtDetailHead(startFrame: CGRect(x: 0, y: -100, width: Device.size.width, height: 100), endFrame: CGRect(x: 0, y: 0, width: Device.size.width, height: 100))
    var table = ThoughtDetailTable(frame: CGRect(origin: .zero, size: CGSize(width: Device.size.width, height: Device.size.height - 100)))
    var entryBar: ThoughtDetailEntryBar!
    
    public var model: ThoughtDetailViewModel! {
        didSet { setView() }
    }
    
    private func setView() {
        
        // set table delegates and datasources
        table.tv.delegate = self
        table.tv.dataSource = self
        
        view.addSubview(headView)
        view.addSubview(table)
        entryBar = ThoughtDetailEntryBar(withConnector: self)
        view.addSubview(entryBar)
    }
}

extension ThoughtDetailController: MSGConnector {
    func save(withTitle title: String, withIcon: ThoughtIcon) { }
    
    func insert<T>(entry: T) where T : EntryBuilder { }
    
    func isDoneEditing() { }
    
    func updateIcon(newIcon: ThoughtIcon) { }
    
    func entryWillShow(ofType type: MSGContext.size) { }
    
    
}


extension ThoughtDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model.entryHeights[indexPath.row]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.entryCount.total
    }
}
