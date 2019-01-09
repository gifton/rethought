//
//  Drawer.swift
//  rethought
//
//  Created by Dev on 1/6/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//drawer view is wrapper for UIView
class DrawerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("initiated drawer view!")
        //dev purposes
        self.addLogoShadow()
        buildDrawer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, controller: DrawerControllerDelegate, dataSource: [DrawerObject]) {
        self.init(frame: frame)
        self.backgroundColor = UIColor(hex: "5066E3")
        self.controller = controller
        put(dataSource)
        buildDrawer()
    }
    
    //position doesnt initialize changes, only for tracking current size
    var position: DrawerPosition = .collapsed
    var state: DrawerState = .closed
    
    var st: DrawerState {
        get {
            return state
        }
        set {
            self.state = newValue
            switch newValue {
            case .closed:
                UIView.animate(withDuration: 0.5) {
                    self.backgroundColor = UIColor(hex: "5066E3")
                }
            case .beginThought:
                UIView.animate(withDuration: 0.5) {
                    self.backgroundColor = UIColor(hex: "61678A")
                }
            case .addTitle:
                UIView.animate(withDuration: 0.5) {
                    self.backgroundColor = UIColor(hex: "5BA6C9")
                }
            case .addEmoji:
                UIView.animate(withDuration: 0.5) {
                    self.backgroundColor = UIColor(hex: "B18387")
                }
            default:
                UIView.animate(withDuration: 0.5) {
                    self.backgroundColor = UIColor(hex: "C9A16F")
                }
            }
        }
    }
    
    //MARK: delegate
    var controller: DrawerControllerDelegate?
    
    //MARK: view holder
    private var initialChildren : [DrawerObject] = []
    private var drawerChildren  : [DrawerObject] = []
}

extension DrawerView {
    func put(_ data: [DrawerObject]) {
        for obj in data {
            if obj.initialState == .closed {
                self.initialChildren.append(obj)
            }
            self.drawerChildren.append(obj)
        }
    }
}

extension DrawerView: DrawerDelegate {
    //when objectSource is called, populate view holders
    var objectSource: [DrawerObject] {
        get {
            var output: [DrawerObject] = []
            let views = [drawerChildren]
            for view in views {
                for obj in view {
                    output.append(obj)
                }
            }
            return output
        }
        set {
            drawerChildren + newValue
        }
    }
    
    //func called from outside view (@objc funcs declared in controller)
    public func change(state: DrawerState) {
        self.st = state
        updateView(with: state)
    }
}

//func for changing drawerPosition
//Closed -> mini
//Mini -> open
//Mini -> closed
//Open -> mini
//Open -> medium
//Medium -> closed

extension DrawerView {
    
    func updateView(with: DrawerState) {
        for child in drawerChildren {
            if child.drawerPositions.contains(with) {
                if child.view.isDescendant(of: self) {
                    continue
                }
                self.addSubview(child.view)
            } else {
                child.view.removeFromSuperview()
            }
        }
    }
}

extension DrawerView {
    func buildDrawer() {
        for obj in self.initialChildren {
            self.addSubview(obj.view)
            print("added drawer to superview")
        }
    }
}

