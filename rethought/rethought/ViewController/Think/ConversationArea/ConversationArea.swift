//
//  ConversationAreaController.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


class ConversationArea: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    let newThoughtView = NewThoughtView(frame: CGRect(x: 0, y: frame.height - 200, width: 0, height: 0), connector: connector)
    
    // MARK: private variables
    var thoughtTitle: String {
        get {
            return createThoughtView.thoughtTitle
        }
    }
    var thoughtIcon: ThoughtIcon {
        get {
            return createThoughtView.thoughtIcon
        }
    }
    
    private func setAtBottom(with size: CGSize) -> CGRect {
        return CGRect(x: 0, y: self.size, width: size.width, height: size.height)
    }
    
    // MARK: private objects
    var createThoughtView: NewThoughtView!
    var createEntryView: EntrybarView!
    lazy var doneButton = UIButton()
}

extension ConversationArea: ConversationDelegate {
    func resetLayout(animated: Bool) {
        self.backgroundColor = UIColor(hex: "F9F9F9")
        createThoughtView = NewThoughtView(frame: setAtBottom(with: CGSize(width: ViewSize.SCREEN_WIDTH, height: 90)))
        addSubview(createThoughtView)
    }
    
    func beginEditingThought() {
        print("begining edits...")
    }
    
    func checkForCompletion() {
        print("check for completion complete")
    }
    
    func thoughtComponentsComplete() {
        print("thoughtcomponents completed")
    }
    
    func addEntry(pf type: EntryType) {
        print("added entry")
    }
    
    func save() {
        print("saving")
    }
    
    var size: CGFloat {
        get {
            return (ViewSize.SCREEN_HEIGHT - (ViewSize.SCREEN_HEIGHT * 0.2))
        }
        set {
            print("size set")
        }
    }
    
    var entrViewSize: CGSize {
        <#code#>
    }
    
    var bottomOfArea: CGFloat {
        <#code#>
    }
    
    
}
