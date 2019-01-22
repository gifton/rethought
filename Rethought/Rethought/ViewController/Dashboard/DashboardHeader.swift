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
    
    let reLogo = UIImageView(image: #imageLiteral(resourceName: "Logo"))
    
    let cvView: UIView = {
        let v = UIView()
        v.backgroundColor = .mainBlue
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
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
        addSubview(allEntriesButton)
        addSubview(searcher)
        addSubview(reLogo)
        allEntriesButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 12.5, paddingTrailing: 20)
        
        searcher.frame.origin = CGPoint(x: 0, y: self.frame.height - 45)
        searcher.frame.size = CGSize(width: ViewSize.SCREEN_WIDTH - 110, height: 40)
        searcher.backgroundImage = UIImage()
        
        reLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            reLogo.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10),
        ])
    }
}
extension DashboardHeader: UISearchBarDelegate {
    
}
