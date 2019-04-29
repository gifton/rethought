//
//  MSGBoard.swift
//  Rethought
//
//  Created by Dev on 4/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MSGBoard: UIScrollView {
    // MARK: public vars
    var currentViewCount: Int {
        return subviews.count
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentSize = CGSize(width: frame.width, height: frame.height + 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetView() {
        // rewmove all thought and entry cards
        //remove response cards
        // replace top welcome card (if removed)
    }
    
//    public func addEntryView<K: EntryBuilder>(payload: K) {
//        // detect currect entry type, instantiate corrosponding view
//        // guard into proper payload based on type
//        // calculate frame
//        // add subView
//        // update layout, content size etc...
//    }
    public func addResponse<T: MSGBoardResponse>(payload: T) {
//         instantiate response card with payload
//         calculate frame
//         add subView
//         update layout, content size etc...
    }
    
}

extension MSGBoard: MSGBoardDelegate {
    func addEntry<K>(_ payload: K, completion: () -> Void) where K : EntryBuilder {
//         detect currect entry type, instantiate corrosponding view
//         guard into proper payload based on type
//         calculate frame
//         add subView
//         update layout, content size etc...
    }
    
    func addThought(_ payload: ThoughtPreview, completino: () -> Void) {
        // instantiate thought card with payload
        // calculate frame
        // add subView
        // update layout, content size etc...

    }
    
    var currentSize: CGSize {
        get {
            return contentSize
        }
        set {
            contentSize = newValue
        }
    }
    
    
}
