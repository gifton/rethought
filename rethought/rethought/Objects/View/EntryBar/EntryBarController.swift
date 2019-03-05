//
//  EntryBar.swift
//  rethought
//
//  Created by Dev on 1/31/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryBarController: UIViewController {
    public var bar: EntrybarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private var del: ThoughtDetailDelegagte!
    
    init(delegate: ThoughtDetailDelegagte) {
        super.init(nibName: nil, bundle: nil)
        self.del = delegate
        bar = EntrybarView(delegate: self)
        self.view = bar!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntryBarController: EntryBarDelegate {
    func newEntry(_ type: EntryType) {
        return
    }
    
    
}
