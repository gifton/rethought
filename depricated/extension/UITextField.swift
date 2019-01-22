//
//  TextField.swift
//  rethought
//
//  Created by Dev on 1/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol ConnectToTextView {
    func textFieldDidFinishEditing(string: String)
}


class ReTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        self.textColor = .darkBackground
        self.textAlignment = .center
        self.layer.masksToBounds = true
        self.addBorders(edges: [.bottom], color: .black, thickness: 8)
    }
    
    convenience init(frame: CGRect, attPlaceholder: String) {
        self.init(frame: frame)
        self.attPlaceholder = attPlaceholder
    }
    
    public var isCompleted: Bool = false
    public var size: CGFloat = 12
    public var color: UIColor = .black
    public var connector: ConnectToTextView?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReTextField: ReTextFieldDelegate {
    public var attPlaceholder: String {
        get {
            return text ?? ""
        }
        set {
            self.attributedPlaceholder = self.addAttributedText(color: color, size: size, font: .body, string: newValue)
        }
    }
}

extension ReTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.attPlaceholder = ""
        self.text = ""
        self.isCompleted = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isCompleted = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.connector?.textFieldDidFinishEditing(string: self.text ?? "nil")
        self.resignFirstResponder()
        return false
    }
    
}

protocol ReTextFieldDelegate {
    var attPlaceholder: String { get set }
}

extension UITextField {
    func addLeftPadding(size: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}



enum ReSearchBarState {
    case closed
    case open
    case finishedSearch
}

//search bar
class ReSearchBar: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size = CGSize(width: 55, height: 25)
        self.addBorders(edges: [.bottom], color: .white, thickness: 4)
        
        setClosedState()
        delegate = self
    }
    
    var searchState: ReSearchBarState = .closed
    public var connector: DashboardHeaderConnector?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var img: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "Search")
        return img
    }()
    
    let cancelBtn = UIButton()
}

extension ReSearchBar {
    func setClosedState() {
        self.leftView = img
        self.leftViewMode = .always
        self.leftViewRect(forBounds: CGRect(x: 5, y: 5, width: 15, height: 15))
    }
}

extension ReSearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1.5) {
            if self.searchState == .closed {
                self.frame.size.width += ViewSize.SCREEN_WIDTH / 1.7
                self.searchState = .open
            } else {
                self.frame.size.width = 35
                self.searchState = .closed
            }
        }
        
        cancelBtn.addAttText(color: .white, size: 10, font: .bodyLight, string: "cancel")
        cancelBtn.backgroundColor = .mainRed
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.layer.masksToBounds = true
        self.rightView = cancelBtn
        self.rightViewMode = .whileEditing
    }
}
