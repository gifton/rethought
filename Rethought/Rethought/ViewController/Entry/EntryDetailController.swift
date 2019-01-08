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
    private var content: Entry?
}

extension EntryDetailController: BackDelegate {
    func returnHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension EntryDetailController: EntryDetailDelegate {
    var entry: Entry {
        get {
            return content ?? Entry(title: "Giftons other title")
        }
        set {
            self.content = newValue
            let newView = EntryDetailView(frame: .zero, entry: content!, delegate: self)
            
            self.view = newView
        }
    }
}
