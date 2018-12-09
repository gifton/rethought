//
//  HomeView.swift
//  rethought
//
//  Created by Dev on 12/8/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "FAFBFF")
        buildOutline()
    }
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        sv.backgroundColor = UIColor(hex: "6271fc")
        
        sv.contentSize = CGSize(width: ScreenSize.SCREEN_WIDTH, height: 800)
        
        return sv
    }()
    
    let newView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: ScreenSize.SCREEN_HEIGHT - 100, width: ScreenSize.SCREEN_WIDTH, height: 100))
        view.backgroundColor = UIColor(hex: "F7D351")
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let thoughtLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 15, y: 50, width: 100, height: 30))
        lbl.text = "Re:Thought"
        lbl.font = UIFont(name: "Lato-Bold", size: 13)
        lbl.textColor = .white
        lbl.backgroundColor = UIColor(hex: "7E86B7")
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 5
        lbl.clipsToBounds = true
        return lbl
    }()
    let continuedThoughtLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 15, y: 90, width: ScreenSize.SCREEN_WIDTH - 150, height: 30))
        lbl.text = "🚂 CONTINUE THE THOUGHT"
        lbl.font = UIFont(name: "Lato-Bold", size: 12)
        lbl.textColor = UIColor(hex: "BFC0C3")
        return lbl
    }()
    let profileButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: ScreenSize.SCREEN_WIDTH - 80, y: 57, width: 60, height: 20))
        btn.setTitle("Profile", for: .normal)
        btn.setTitleColor(UIColor(hex: "E91E63"), for: .normal)
        
        return btn
    }()
    let currentThoughtsView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 125, width: ScreenSize.SCREEN_WIDTH, height: 100))
        view.backgroundColor = .accentGray
        
        return view
    }()
    let newThoughtButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 15, y: 250, width: ScreenSize.SCREEN_WIDTH - 30, height: 55))
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Regular", size: 20),  NSAttributedString.Key.foregroundColor: UIColor.white]
        let myAttrString = NSAttributedString(string: "Create new Thought", attributes: attribute as [NSAttributedString.Key : Any])
        btn.setAttributedTitle(myAttrString, for: .normal)
        btn.backgroundColor = UIColor(hex: "5DCBA5")
        btn.layer.cornerRadius = 4
        return btn
    }()
    let recentEntriesView: UIView = {
        let view = UIView()
        view.backgroundColor = .blueSmoke
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    let reccomendedThought: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "55AFF8")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildOutline() {
        addSubview(thoughtLabel)
        addSubview(profileButton)
        addSubview(scrollView)
        addSubview(newView)
        scrollView.frame.origin = CGPoint(x: 0, y: 100)
        
        var yValue = 40
        for _ in 1...10 {
            let view = UIView(frame: CGRect(x: Int((ScreenSize.SCREEN_WIDTH - 300) / 2), y: yValue, width: 300, height: 70))
            view.backgroundColor = .random
            view.layer.cornerRadius = 5
            view.layer.masksToBounds = true
            
            scrollView.addSubview(view)
            yValue += 80
        }
    }
    
    func buildStaticObjects() {
        addSubview(newView)
        addSubview(scrollView)
        addSubview(thoughtLabel)
        addSubview(continuedThoughtLabel)
        addSubview(profileButton)
        addSubview(currentThoughtsView)
        addSubview(newThoughtButton)
        addSubview(recentEntriesView)
        addSubview(reccomendedThought)
        newView.setHeightWidth(width: ScreenSize.SCREEN_WIDTH, height: 100)
        recentEntriesView.setHeightWidth(width: ScreenSize.SCREEN_WIDTH - 30, height: 300)
        reccomendedThought.setHeightWidth(width: 350, height: 160)
        NSLayoutConstraint.activate([
            newView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            newView.centerXAnchor.constraint(equalTo: centerXAnchor),
            recentEntriesView.topAnchor.constraint(equalTo: newThoughtButton.bottomAnchor, constant: 25),
            recentEntriesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            reccomendedThought.topAnchor.constraint(equalTo: recentEntriesView.bottomAnchor, constant: 25),
            reccomendedThought.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
        ])
        
    }
}
