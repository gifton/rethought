//
//  NewTextEntry.swift
//  rethought
//
//  Created by Dev on 1/16/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class NewTextEntry: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var delegate: ThoughtCardDelegate?
    var returnDescription: String = ""
    var returnTitle: String = ""
    
    var titleTextView: UITextView = {
        let tv = UITextView()
        
        return tv
    }()
    var descriptionTextView: UITextView = {
        let tv = UITextView()
        
        return tv
    }()
    var doneButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: "51DF9F")
        btn.setAttributedTitle(btn.addAttributedText(size: 12, font: .title, string: "Save"), for: .normal)
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        titleTextView.backgroundColor = UIColor(hex: "161616")
        titleTextView.attributedText = titleTextView.addAttributedText(size: 14, font: .body, string: "add a title")
        doneButton.frame = CGRect(x: 25, y: 500, width: ViewSize.SCREEN_WIDTH - 50, height: 59)
        titleTextView.frame = CGRect(x: 15, y: 50, width: ViewSize.SCREEN_WIDTH - 30, height: 54)
        
        view.addSubview(titleTextView)
        view.addSubview(doneButton)
    }
}
