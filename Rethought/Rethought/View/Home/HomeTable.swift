//
//  HomeTable.swift
//  Rethought
//
//  Created by Dev on 5/14/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeTable: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Device.colors.offWhite
        setView()
    }
    
    // MARK: public variables
    public var animator: Animator?
    public let tv: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.allowsMultipleSelection = false
        tv.backgroundColor = Device.colors.offWhite
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.allowsSelection = false
        
        return tv
    }()
    
    // MARK: private variables
    private let filterButton = UIButton()
    private let entryLabel = UILabel()
    
    
    private func setView() {
        tv.delegate = self
        tv.register(cellWithClass: HomeTableCell.self)
        
        addSubview(tv)
        addSubview(filterButton)
        addSubview(entryLabel)
        
        tv.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 50, paddingLeading: 0, paddingBottom: 5, paddingTrailing: 0)

        filterButton.setAnchor(top: topAnchor, leading: nil, bottom: tv.topAnchor, trailing: trailingAnchor, paddingTop: 15, paddingLeading: 0, paddingBottom: 10, paddingTrailing: 30)
        filterButton.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        
        entryLabel.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 15, paddingLeading: 20)
        entryLabel.font = Device.font.mediumTitle(ofSize: .xLarge)
        entryLabel.text = "Recent Entries"
        entryLabel.textColor = Device.colors.red
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has notbeen implemented")
    }
    
    // MARK: Variables for scrolling update calculations
    private let endFrame: CGFloat = 170
    private let startFrame: CGFloat = 500
    public var animationScrollLength: CGFloat = 330.0
    private var lastOffset: CGFloat = 0.0
    public var animationProgress: CGFloat {
        if tv.numberOfRows(inSection: 0) > 6 {
            let offset = tv.contentOffset.y
            let normalizedOffset = max(0.0, min(1.0, offset/animationScrollLength))
            return normalizedOffset
        }
        return 0
    }
    
    // update accordinf to animation progress
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        frame.origin.y = startFrame + ((endFrame - startFrame) * animationProgress)
        frame.size.height = (Device.size.height - frame.origin.y)
        
        //alert controller of movement to animate individual seperate views
        animator?.didUpdate()
    }
}

extension HomeTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
