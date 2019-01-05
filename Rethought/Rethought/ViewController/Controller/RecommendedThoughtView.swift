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
        self.addSubview(backgroundImage)
        backgroundImage.image = #imageLiteral(resourceName: "ReccomendedThought")
        backgroundImage.frame = frame
    }
    
    private var titleLabel = UILabel()
    private var iconWrapper = UIView()
    private var iconLabel = UILabel()
    private var linkLabel = UILabel()
    private var entryLabel = UILabel()
    private var mediaLabel = UILabel()
    private var dayCountLabel = UILabel()
    var backgroundImage = UIImageView()
    private var thoughtCell = UIView()
    
    var welcomeTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Recommended Thought"
        lbl.font = .reTitle(ofSize: 20)
        lbl.textColor = .white
        
        return lbl
    }()
    
    private var titleText: String?
    private var icon: String?
    private var linkCount: Int?
    private var entryCount: Int?
    private var mediaCount: Int?
    private var dayCount: Int?
    
    convenience init(thought: ThoughtPreviewLarge, frame: CGRect) {
        self.init(frame: frame)
        self.titleText = thought.title
        self.icon = thought.icon
        self.linkCount = thought.entryCount["links"]
        self.entryCount = thought.entryCount["entries"]
        self.mediaCount = thought.entryCount["media"]
        self.dayCount = 6
        setupCell()
    }
    
    private func setupCell() {
        
        let stack = createStack()
        
        addSubview(thoughtCell)
        addSubview(welcomeTitle)
        thoughtCell.addSubview(titleLabel)
        thoughtCell.addSubview(iconWrapper)
        thoughtCell.addSubview(stack)
        
        iconWrapper.addSubview(iconLabel)
        
        styleView()
        
        addContext()
    }
    
    private func styleView() {
        welcomeTitle.frame = CGRect(x: 22, y: 100, width: 300, height: 40)
        thoughtCell.frame.size = CGSize(width: 325, height: 70)
        thoughtCell.center = center
        thoughtCell.blurBackground(type: .extraLight, cornerRadius: 8)
        
        //141 is 76 (padding left for icon) + 65 (padding for date icon)
        titleLabel.font = UIFont.reTitle(ofSize: 16)
        titleLabel.frame = CGRect(x: 76, y: 7, width: thoughtCell.frame.width - 141, height: 25)
        
        iconWrapper.frame = CGRect(x: 10, y: 7, width: 56, height: 56)
        iconWrapper.backgroundColor = .white
        iconWrapper.layer.cornerRadius = 5
        
        iconLabel.frame = iconWrapper.bounds
        iconLabel.textAlignment = .center
        iconLabel.font = UIFont.reTitle(ofSize: 30)
        
        let lbls = [linkLabel, mediaLabel, dayCountLabel, entryLabel]
        
        for lbl in lbls {
            lbl.font = .reBody(ofSize: 12)
            lbl.textColor = .white
        }
        self.titleLabel.font = .reTitle(ofSize: 16)
        self.titleLabel.textColor = .white
    }
    
    private func createStack() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [linkLabel, entryLabel, mediaLabel])
        stackView.axis = .horizontal
        
//        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.frame = CGRect(x: 77, y: 45, width: 150, height: 20)
        
        return stackView
    }
    
    private func addContext() {
        guard let title = self.titleText else { return }
        guard let icon = self.icon else { return }
        guard let linkCount = self.linkCount else { return }
        guard let entryCount = self.entryCount else { return }
        guard let mediaCount: Int = self.mediaCount else { return }
        guard let dayCount: Int = self.dayCount else { return }
        
        self.titleLabel.text = title
        self.iconLabel.text = icon
        self.linkLabel.text = String(describing: linkCount) + " Links"
        self.entryLabel.text = String(describing: entryCount) + " Entries"
        self.mediaLabel.text = String(describing: mediaCount) + " media"
        self.dayCountLabel.text = String(describing: dayCount)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
