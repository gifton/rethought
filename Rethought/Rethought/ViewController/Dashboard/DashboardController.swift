//
//  DashboardController.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DashboardController: UIViewController {
    var thoughtCard: ThoughtCardController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = DashboardView()
        thoughtCard = ThoughtCardController()
        thoughtCard?.setCard(delegate: self)
        
        self.addChild(thoughtCard!)
        self.view.addSubview(thoughtCard!.card!)
        
        thoughtCard!.didMove(toParent: self)
    }
}

extension DashboardController: DashboardDelegate {
    func changeSize(size: ThoughtCardState) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 2.0, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveEaseIn, animations: {
            switch size {
            case .collapsed:
                self.thoughtCard?.card?.frame = CGRect(x: 10, y: ViewSize.SCREEN_HEIGHT * 0.87, width: ViewSize.SCREEN_WIDTH - 20, height: 69)
            default:
                self.thoughtCard?.card?.frame = CGRect(x: 10, y: (ViewSize.SCREEN_HEIGHT * 0.184) , width: ViewSize.SCREEN_WIDTH - 20, height: 367)
            }
        }) { (true) in
            print("complete")
        }
        
    }
}
