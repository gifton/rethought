//
//  EntryCountBlock.swift
//  Rethought
//
//  Created by Dev on 5/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryCountBlock: UIView {
    init(withCount count: EntryCount) {
        self.count = count
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 120, height: 35)))
        
    }
    
    var count: EntryCount
    private let linkImage = UIImageView()
    private let linkLabel = UILabel()
    
    private let noteImage = UIImageView()
    private let noteLabel = UILabel()
    
    private let recordingImage = UIImageView()
    private let recordingLabel = UILabel()
    
    private let photoImage = UIImageView()
    private let photoLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        
    }
    
    private func createView(forType type: EntryType) -> UIView {
        let stack = UIStackView()
        
        return stack
    }
}
