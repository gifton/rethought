 //
//  EntryCountView.swift
//  rethought
//
//  Created by Dev on 1/29/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
 
 class EntryCountView: UIView {
    init() {
        let frame = CGRect(x: 10, y: 210, width: ViewSize.SCREEN_WIDTH - 20, height: 40)
        super.init(frame: frame)
    }
    
    private var media:      String!
    private var links:      String!
    private var recordings: String!
    private var text:       String!
    
    private var mediaLabel      = UILabel()
    private var linksLabel      = UILabel()
    private var recordingsLabel = UILabel()
    private var textLabel       = UILabel()
    
    convenience init(media: Int, links: Int, recordings: Int, text: Int) {
        self.init()
        self.media = String(describing: media)
        self.links = String(describing: links)
        self.recordings = String(describing: recordings)
        self.text = String(describing: text)
        
        giveContext()
        setView()
        styleView()
    }
    
    private func giveContext() {
        mediaLabel.addText(size: 12, font: .body, string: media + " media")
        linksLabel.addText(size: 12, font: .body, string: links + " links")
        recordingsLabel.addText(size: 12, font: .body, string: recordings + " recordings")
        textLabel.addText(size: 12, font: .body, string: text + " entries")
    }
    
    private func setView() {
        let stack = UIStackView(arrangedSubviews: [mediaLabel, linksLabel, recordingsLabel, textLabel])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        addSubview(stack)
        stack.frame = CGRect(x: 15, y: 0, width: ViewSize.SCREEN_WIDTH - 60, height: 40)
        
    }
    
    private func styleView()  {
        let color = UIColor(hex: "848484")
        let views = [mediaLabel, linksLabel, recordingsLabel, textLabel]
        for view in views {
            view.textColor = color
        }
        
        self.backgroundColor = UIColor(hex: "161616")
        self.layer.cornerRadius = 5
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }

