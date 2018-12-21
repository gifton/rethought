//
//  RecommendedThoughtView.swift
//  rethought
//
//  Created by Dev on 12/20/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


class RecommendedThoughtView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size = CGSize(width: 350, height: 156)
        self.addSubview(backgroundImage)
        backgroundImage.image = #imageLiteral(resourceName: "ReccomendedThought")
        
    }
    
    private var title = UILabel()
    private var icon = UILabel()
    private var linkLabel = UILabel()
    private var entryLabel = UILabel()
    private var mediaLabel = UILabel()
    private var dayCount = UILabel()
    var backgroundImage = UIImageView()
    
    
    convenience init(thought: Thought, frame: CGRect) {
        self.init(frame: frame)
        self.title.text = thought.title
        self.icon.text = thought.icon
        self.linkLabel.text = String(describing: thought.entryCount["links"])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
