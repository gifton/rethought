//
//  ThoughtDetailEntryBar.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailEntryBar: UIView {
    init(withDelegate delegate: ThoughtDetailDelegate) {
        self.delegate = delegate
        super.init(frame: CGRect(x: 0, y: Device.size.height - 95, width: Device.size.width, height: 95))
        
        backgroundColor = .black
        setView()
    }
    
    // MARK: public vars
    public var delegate: ThoughtDetailDelegate
    
    // MARK: private objects
    private var noteButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "newNote"), for: .normal)
        btn.frame.size = CGSize(width: 20, height: 20)
        btn.entryType = .note
        btn.messageButtonType = .entry
        
        return btn
    }()
    private var linkButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "Link_light"), for: .normal)
        btn.frame.size = CGSize(width: 20, height: 20)
        btn.entryType = .link
        btn.messageButtonType = .entry
        
        return btn
    }()
    private var recordingButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "recordings button"), for: .normal)
        btn.frame.size = CGSize(width: 13.74, height: 20)
        btn.entryType = .recording
        btn.messageButtonType = .entry
        
        return btn
    }()
    private var photoButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "photo_btn"), for: .normal)
        btn.frame.size = CGSize(width: 24, height: 24)
        btn.imageView?.tintColor = .red
        btn.entryType = .photo
        btn.messageButtonType = .entry
        
        return btn
    }()
    private var collapseButton: UIButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "collapse"), for: .normal)
        btn.frame.size = CGSize(width: 24, height: 20)
        
        return btn
    }()
    
    private func setView() {
        // add buttons to view
        // TODO: Make this a stack view
        var startX: CGFloat = 20.0
        let startY: CGFloat = 22.5
        for btn in [noteButton, linkButton, recordingButton, photoButton] {
            
            if !(btn.isDescendant(of: self)) {
                btn.frame = CGRect(x: startX, y: startY, width: btn.frame.width, height: btn.frame.height)
                addSubview(btn)
                btn.addTapGestureRecognizer { _ = self.delegate.displayEntryType(btn.entryType) }
                startX += (btn.frame.width + 35)
            }
        }
        
        addSubview(collapseButton)
        collapseButton.frame = CGRect(x: frame.width - 65, y: 10, width: 50, height: 50)
        collapseButton.addTapGestureRecognizer {
            self.delegate.requestClose()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
