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
}

extension EntryDetailController: BackDelegate {
    func returnHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension EntryDetailController: EntryDetailDelegate {
    var entry: Entry {
        didSet {
            
            entryView = EntryDetailView(frame: .zero, entry: newValue, delegate: self)
            
            self.view = entryView
        }
    }
}
