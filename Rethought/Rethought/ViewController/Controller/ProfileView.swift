//
//  ProfileView.swift
//  rethought
//
//  Created by Dev on 12/9/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: UIView {
    var firstName: String?
    var lastName: String?
    open var delegate: HomeDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "FAFBFF")
        
    }
    convenience init(frame: CGRect, firstName: String, lastName: String, email: String) {
        self.init(frame: frame)
        self.firstName = firstName
        self.lastName = lastName
        
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "121212")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statsButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("View my stats", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    let photoButton: UIButton = {
        let btn = UIButton()
        let buttonSize: CGFloat = 100
        btn.layer.cornerRadius = buttonSize / 2
        btn.layer.masksToBounds = true
        btn.setHeightWidth(width: buttonSize, height: buttonSize)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .random
        
        return btn
    }()
    let firstnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font =  UIFont(name: "HelveticaNeue-bold", size: fontSize.xXLarge.rawValue)
        lbl.textColor = .white
        
        return lbl
    }()
    let lastnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font =  UIFont(name: "HelveticaNeue-light", size: fontSize.xLarge.rawValue)
        lbl.textColor = .white
        
        return lbl
    }()
    let emailTextView: UITextView = {
        let tv = UITextView()
        tv.text = "giftono@gmail.com"
        return tv
    }()
    let changePass: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: 121212)
        btn.setTitle("Change Password", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    let logout: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: 121212)
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor.mainBlue.cgColor
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    let deleteAccount: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: 121212)
        btn.setTitle("Delete Account", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor(hex: "D63864").cgColor
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    let backButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Back", for: .normal)
        btn.backgroundColor = UIColor(hex: "E0E1E9")
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(userWantsToGoHome), for: .touchUpInside)
        
        return btn
    }()
    
    
    fileprivate func buildView() {
        addSubview(headerView)
        headerView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        headerView.heightAnchor.constraint(equalToConstant: ViewSize.SCREEN_HEIGHT / 4).isActive = true
        
        headerView.addSubview(firstnameLabel)
        headerView.addSubview(lastnameLabel)
        headerView.addSubview(statsButton)
        headerView.addSubview(photoButton)
        
        if firstName != nil && lastName != nil {
            firstnameLabel.text = self.firstName
            lastnameLabel.text = self.lastName
        }
        
        photoButton.setAnchor(top: safeTopAnchor, leading: nil, bottom: nil, trailing: safeTrailingAnchor, paddingTop: 10, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 5)
        firstnameLabel.setAnchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 55, paddingLeading: 25, paddingBottom: 0, paddingTrailing: 0)
        lastnameLabel.setAnchor(top: firstnameLabel.bottomAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 5, paddingLeading: 25, paddingBottom: 0, paddingTrailing: 0)
        statsButton.setAnchor(top: lastnameLabel.bottomAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 25, paddingLeading: 25, paddingBottom: 0, paddingTrailing: 0)
        
        let buttons = [logout, changePass, deleteAccount]
        var centerPointY = (ViewSize.SCREEN_HEIGHT / 4) + 15
        for button in buttons {
            addSubview(button)
            button.frame.origin = CGPoint(x: (ViewSize.SCREEN_WIDTH - 200) / 2, y: centerPointY)
            button.frame.size = CGSize(width: 200, height: 60)
            centerPointY += 80
        }
        
        addSubview(backButton)
        backButton.frame = CGRect(x: 50, y: 500, width: 100, height: 40)
        
    }
    
    @objc func userWantsToGoHome()  {
        self.delegate?.userPressedHomeButton()
    }
}

