//
//  ThoughtBuilderController.swift
//  Rethought
//
//  Created by Dev on 4/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtBuilderController: UIViewController {
    
    // Mark: Private vars
    var model: ThoughtBuilderViewModel
    // Mark: public vars
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(withModel model: ThoughtBuilderViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThoughtBuilderController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(frame: .zero)
    }
    
    
}
