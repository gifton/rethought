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
        layer.borderWidth = 1
        layer.borderColor = Device.colors.lightGray.cgColor
        setView()
    }
    
    public var animator: Animator?
    
    let tv: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.allowsMultipleSelection = false
        tv.backgroundColor = .green
        tv.bounces = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    func setView() {
        tv.delegate = self
        tv.dataSource = self
        addSubview(tv)
        tv.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 5, paddingTrailing: 5)

        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Variables for scrolling update calculations
    private var oldContentOffset = CGPoint.zero
    private let endFrame: CGFloat = 170
    private let startFrame: CGFloat = 400
    public var animationScrollLength: CGFloat = 230.0
    public var animationProgress: CGFloat {
        let offset = tv.contentOffset.y
        let normalizedOffset = max(0.0, min(1.0, offset/animationScrollLength))
        return normalizedOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        if (delta > 0) && (frame.origin.y > endFrame) {
            frame.origin.y -= delta
        } else if (delta < 0) && (frame.origin.y < startFrame) {
            frame.origin.y -= delta
        }
        frame.size.height = (Device.size.height - frame.origin.y)
        
        //alert controller of movement to animate individual seperate views
        animator?.didUpdate()
        
        oldContentOffset = scrollView.contentOffset
    }
}

extension HomeTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
