//
//  MSGCenterRecordingView.swift
//  Rethought
//
//  Created by Dev on 5/12/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MSGCenterRecordingView: UIView {
    init(frame: CGRect, bus: EntryComponentBus) {
        self.bus = bus
        super.init(frame: frame)
        
    }
    
    private var bus: EntryComponentBus
    private var recording: Any?
    
    
    // MARK: Objects
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
