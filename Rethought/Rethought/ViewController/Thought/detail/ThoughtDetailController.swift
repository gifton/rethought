//
//  ThoughtDetailController.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "506686")
    }
    
    init(withThoughtModel model: ThoughtDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        
        let newEntryView = EntryBarController(delegate: self)
        self.addChild(newEntryView)
        self.view.addSubview(newEntryView.bar)
        newEntryView.didMove(toParent: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: ThoughtDetailViewModel? {
        didSet {
            self.view = ThoughtDetailView(frame: .zero, thought: self.model?.thought ?? Thought(), delegate: self)
        }
    }
}

extension ThoughtDetailController: ThoughtDetailDelegagte  {
    func userTapped(on entryID: String) {
        print("aww jeez! \(entryID)")
    }
    
    
}

extension ThoughtDetailController: BackDelegate {
    func returnHome() {
        self.navigationController?.popViewController(animated: true)
    }
}
