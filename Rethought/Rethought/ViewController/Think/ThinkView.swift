//
//  ThinkView.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThinkView: UIView {
    init(with connector: ThinkDelegate) {
        super.init(frame: .zero)
        self.delegate = connector
        backgroundColor = UIColor(hex: "f9f9f9")
        setTableView()
    }
    
    var delegate: ThinkDelegate?
    
    let thinkTable: UITableView = {
        let tv = UITableView()
        tv.frame = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 236, width: ViewSize.SCREEN_WIDTH, height: 90)
        
        return tv
    }()
    
    func setTableView() {
        thinkTable.delegate = self
        thinkTable.dataSource = self
        thinkTable.register(CreateNewThoughtCell.self, forCellReuseIdentifier: CreateNewThoughtCell.identifier)
        addSubview(thinkTable)
        
        print("tableview added!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ThinkView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreateNewThoughtCell.identifier, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension ThinkView: UITableViewDelegate {
    
}

extension ThinkView: ThinkDelegate {
    func thoughtComponentsCompleted() {
        thinkTable.frame.origin.y -= 140
    }
    
    func createEntry(of type: EntryType) {
        print("created entry")
    }
}
