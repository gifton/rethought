//
//  EntryActionBar.swift
//  Rethought
//
//  Created by Dev on 6/7/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryActionBar: UIView {
    init(withOrigin origin: CGPoint, thoughtIcon icon: ThoughtIcon) {
        self.icon = icon
        super.init(frame: CGRect(origin: origin, size: CGSize(width: Device.size.width - 30, height: 65)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private variables
    var icon: ThoughtIcon
    
    // MARK: private objects
    private var iconLabel = UILabel()
    private var closeBtn = UIButton()
    private var infoView = UIView()
    private var deleteButton = UIButton()
}
