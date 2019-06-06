//
//  EntryDetailController.swift
//  Rethought
//
//  Created by Dev on 6/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol EntryDetailDelegate {
    func updateEntry(withEntry: EntryBuilder)
}

class EntryDetailController: UIViewController {
    var model: EntryDetailViewModel
    var entry: Entry { return model.entry }
    
    init(withModel model: EntryDetailViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        view = EntryDetalScrollView(withBuilder: <#T##EntryBuilder#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntryDetailController: EntryDetailDelegate {
    func updateEntry(withEntry: EntryBuilder) { }
}
