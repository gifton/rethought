//
//  DashboardHeader.swift
//  rethought
//
//  Created by Dev on 1/22/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DashboardHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setViews()
    }
    
    convenience init(frame: CGRect, delegate: DashboardDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
    }
    override var reuseIdentifier: String? {
        return "ThoughtFeedCellTile"
    }
    static var identifier: String {
        return "ThoughtFeedCellTile"
    }
    public var delegate: DashboardDelegate?
    
    let allEntriesButton: UIButton = {
        let btn = UIButton()
        btn.addAttText(color: UIColor(hex: "51DF9F"), size: 13, font: .title, string: "All entries")
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    var searchTextView = ReSearchBar()
    
    var searcher: UISearchBar = {
        let sb = UISearchBar()
        sb.barStyle = .blackOpaque
        sb.returnKeyType = .search
        
        return sb
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DashboardHeader {
    func setViews() {
        searchTextView.connector = self
        addSubview(allEntriesButton)
        addSubview(searcher)
        allEntriesButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 12.5, paddingTrailing: 25)
        
        searcher.frame.origin = CGPoint(x: 0, y: self.frame.height - 45)
        searcher.frame.size = CGSize(width: ViewSize.SCREEN_WIDTH - 110, height: 40)
        searcher.backgroundImage = UIImage()
        
    }
}

extension DashboardHeader: DashboardHeaderConnector {
    func userTapped(on searchBar: ReSearchBarState) {
        UIView.animate(withDuration: 1.5) {
            if self.searchTextView.searchState == .closed {
                self.searchTextView.frame.size.width += ViewSize.SCREEN_WIDTH / 1.7
                self.searchTextView.searchState = .open
            } else {
                self.searchTextView.frame.size.width = 35
                self.searchTextView.searchState = .closed
            }
        }
    }
}


protocol DashboardHeaderConnector {
    func userTapped(on searchBar: ReSearchBarState)
//    func userQuery(_ query: String) -> [DashboardThought]
}

extension DashboardHeader: UISearchBarDelegate {
    
}
