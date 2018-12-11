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
    fileprivate var detailThought: Thought = Thought()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "55AFF8")
        buildView()
    }
    
    
    let backButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.backgroundColor = .mainBlue
        btn.setTitle("🔙", for: .normal)
        return btn
    }()
    
    var testlabel = UILabel(frame: CGRect(x: 120, y: 100, width: 100, height: 40))
    
    func buildView() {
        view.addSubview(backButton)
        view.addSubview(testlabel)
        backButton.frame = CGRect(x: 25, y: 80, width: 100, height: 30)
        backButton.addTarget(self, action: #selector(returnHome), for: .touchUpInside)
        
    }
    
    @objc func returnHome() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ThoughtDetailController: DetailThoughtDelegate {
    var thought: Thought {
        get {
            return detailThought 
        }
        set {
            self.detailThought = newValue
            self.testlabel.text = newValue.title
        }
    }
    
    
}

protocol DetailThoughtDelegate {
    var thought: Thought { get set }
}
