//
//  ProfileViewController.swift
//  rethought
//
//  Created by Dev on 12/9/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let pView = ProfileView(frame: .zero, firstName: "Gifton", lastName: "Okoronkwo", email: "giftono@gmail.com")
        pView.delegate = self
        self.view = pView
    }
}

extension ProfileViewController: HomeDelegate {
    func userPressedHomeButton() {
        navigationController?.pushViewController(HomeViewController(), animated: false)
    }
}

protocol ProfileProtocol {
    func userDidPressProfile()
}

protocol HomeDelegate {
    func userPressedHomeButton()
}
