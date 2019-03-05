//
//  EntryDetailController.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryDetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var entryView: EntryDetailView?
    
    var entry: Entry!
    
}

extension EntryDetailController: BackDelegate {
    func returnHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
