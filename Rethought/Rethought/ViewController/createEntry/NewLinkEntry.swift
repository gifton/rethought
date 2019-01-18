//
//  NewLinkEntry.swift
//  rethought
//
//  Created by Dev on 1/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class NewLinkEntry: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    public var entry          : Entry?
    public var delegate       : ThoughtCardDelegate?
    public var parentThought  : Thought?
    var urlString: String {
        get {
            return entry?.description ?? "Add a title for your entry"
        }
    }
    var titleString: String {
        get {
            return entry?.title ?? "okay, start at the begining"
        }
    }
    
    var mainImage = UIImageView()
    var linkTextField: ReTextField?
    var titleLabel = UILabel()
}


extension NewLinkEntry {
    private func setupView() {
        self.view.backgroundColor = .white
        mainImage.image = .random()
        mainImage.frame.size = CGSize(width: 150, height: 150)
        mainImage.contentMode = .scaleToFill
        mainImage.center = CGPoint(x: self.view.center.x, y: 200)
        
        linkTextField = ReTextField(frame: CGRect(x: 25, y: 350, width: ViewSize.SCREEN_WIDTH - 50, height: 59), attPlaceholder: "https://www.wesaturate.com")
        
        self.view.addSubview(mainImage)
        self.view.addSubview(linkTextField!)
    }
}
