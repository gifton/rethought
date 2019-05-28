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
    init(withCount count: EntryCount, frame: CGRect) {
        self.count = count
        super.init(frame: frame)
        setView()
    }
    
    var count: EntryCount
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        for type in EntryType.exhaustiveList() {
            if type == .all { continue }
            let view = createView(forType: type)
            addSubview(view)
        }
    }
    
    private func createView(forType type: EntryType) -> UIView {
        let outView = UIView()
        let image = UIImageView()
        let lbl = UILabel()
        outView.addSubview(image)
        outView.addSubview(lbl)
        
        lbl.adjustsFontSizeToFitWidth = true
        
        switch type {
        case .link:
            image.image = #imageLiteral(resourceName: "Link_light")
            image.setHeightWidth(width: 14, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: frame.width - 43, y: 19), size: CGSize(width: 43, height: 14))
            lbl.text = "\(count.linkInt)"
            lbl.textColor = Device.colors.link
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        case .note:
            image.image = #imageLiteral(resourceName: "newNote")
            lbl.text = "\(count.noteInt)"
            lbl.textColor = Device.colors.note
            image.setHeightWidth(width: 14, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: frame.width - 43, y: 0), size: CGSize(width: 42, height: 14))
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        case .recording:
            image.image = #imageLiteral(resourceName: "recordings button")
            image.setHeightWidth(width: 10, height: 14)
            outView.frame = CGRect(origin: .zero, size: CGSize(width: 38, height: 14))
            lbl.text = "\(count.recordingInt)"
            lbl.textColor = Device.colors.recording
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 2)
        default:
            image.image = #imageLiteral(resourceName: "photo_btn")
            image.setHeightWidth(width: 16, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: 0, y: 19), size: CGSize(width: 42, height: 14))
            lbl.text = "\(count.photoInt)"
            lbl.textColor = Device.colors.photo
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        }
        lbl.setAnchor(top: outView.topAnchor, leading: image.trailingAnchor, bottom: outView.bottomAnchor, trailing: outView.trailingAnchor, paddingTop: 0, paddingLeading: 8, paddingBottom: 0, paddingTrailing: 2)
        
        return outView
    }
}
