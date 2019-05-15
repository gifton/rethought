//
//  HomeController.swift
//  Rethought
//
//  Created by Dev on 5/14/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        setView()
    }
    
    let topView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        
        return view
    }()
    
    func setView() {
        view.addSubview(topView)
        let tv = HomeTable(frame: CGRect(x: 0, y: 400, width: Device.size.width, height: Device.size.height - 400))
        
        view.addSubview(tv)
        topView.bottomAnchor.constraint(equalTo: tv.topAnchor, constant: 10).isActive = true
        topView.setHeightWidth(width: Device.size.width, height: 100)
    }
    
}
