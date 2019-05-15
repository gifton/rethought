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
    
    let tv: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.allowsMultipleSelection = false
        tv.backgroundColor = .green
        tv.alwaysBounceVertical = true
        tv.bounces = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    func setView() {
        tv.delegate = self
        tv.dataSource = self
        addSubview(tv)
        tv.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 5, paddingTrailing: 5)
        
        print("----------")
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(0)..<CGFloat(140))
    let topTableAnchor: CGFloat = 170
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta =  scrollView.contentOffset.y - oldContentOffset.y
        
        if delta > 0 && !(frame.origin.y <= 175.0) {
            print("scrolling up?")
            frame.origin.y -= delta
            frame.size.height += delta
        } else {
            frame.origin.y += delta
            frame.size.height -= delta
        }
        //TODO: add delegate that alerts controller of movement to animate individual views
        
        oldContentOffset = scrollView.contentOffset
    }
}

extension HomeTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
