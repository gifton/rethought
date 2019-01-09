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
        self.addBorders(edges: .top, color: .white, thickness: 10.0)
        buildDrawer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, controller: DrawerControllerDelegate, dataSource: [DrawerObject]) {
        self.init(frame: frame)
        self.controller = controller
        put(dataSource)
        buildDrawer()
    }
    
    //position doesnt initialize changes, only for tracking current size
    var position: DrawerPosition = .collapsed
    var state: DrawerState = .closed
    
    //MARK: delegate
    var controller: DrawerControllerDelegate?
    
    //MARK: view holders
    private var closedChildren:             [DrawerObject] = []
    private var beginThoughtChildren:       [DrawerObject] = []
    private var titleChildren:              [DrawerObject] = []
    private var emojiChildren:              [DrawerObject] = []
    private var continueTheThoughtChildren: [DrawerObject] = []
}

extension DrawerView {
    func put(_ data: [DrawerObject]) {
        for obj in data {
            
            switch obj.initialState{
            case .addEmoji:
                emojiChildren.append(obj)
            case .addTitle:
                titleChildren.append(obj)
            case .beginThought:
                beginThoughtChildren.append(obj)
            case .closed:
                closedChildren.append(obj)
            case .continueTheThought:
                continueTheThoughtChildren.append(obj)
            }
        }
        print(beginThoughtChildren)
    }
}

extension DrawerView: DrawerDelegate {
    //when objectSource is called, populate view holders
    var objectSource: [DrawerObject] {
        get {
            var output: [DrawerObject] = []
            let views = [closedChildren, beginThoughtChildren, titleChildren, emojiChildren, continueTheThoughtChildren]
            for view in views {
                for obj in view {
                    output.append(obj)
                }
            }
            return output
        }
        set {
            for obj in newValue {
                switch obj.initialState{
                case .addEmoji:
                    emojiChildren.append(obj)
                case .addTitle:
                    titleChildren.append(obj)
                case .beginThought:
                    beginThoughtChildren.append(obj)
                case .closed:
                    closedChildren.append(obj)
                case .continueTheThought:
                    continueTheThoughtChildren.append(obj)
                }
            }
        }
    }
    
    //func called from outside view (@objc funcs declared in controller)
    public func change(state to: DrawerState) {
        switch to {
        case .addEmoji:
            buildThoughtEmojiView()
            print("emoji!")
        case .addTitle:
            buildThoughtTitleView()
            print("title")
        case .beginThought:
            buildBeginThoughtView()
        case .closed:
            buildClosedView()
            print("closed")
        case .continueTheThought:
            buildContinueTheThought()
        }
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

    private func buildClosedView() {
        switch state {
        case .beginThought:
            for obj in self.beginThoughtChildren {
                obj.view.removeFromSuperview()
            }
        case .continueTheThought:
            for obj in self.continueTheThoughtChildren {
                obj.view.removeFromSuperview()
            }
        default:
            return
        }
    }
    private func buildBeginThoughtView() {
        switch state {
        case .closed:
            for obj in self.beginThoughtChildren {
                obj.view.removeFromSuperview()
            }
        case .addEmoji:
            for obj in self.emojiChildren {
                obj.view.removeFromSuperview()
            }
        case .addTitle:
            for obj in self.titleChildren {
                obj.view.removeFromSuperview()
            }
        default:
            return
        }
        for obj in self.beginThoughtChildren {
            addSubview(obj.view)
        }
    }
    private func buildThoughtTitleView() {
        switch state {
        case .beginThought:
            for obj in self.beginThoughtChildren {
                obj.view.removeFromSuperview()
            }
        default:
            return
        }
        for obj in self.titleChildren {
            addSubview(obj.view)
        }
    }
    private func buildThoughtEmojiView() {
        switch state {
        case .beginThought:
            for obj in self.beginThoughtChildren {
                obj.view.removeFromSuperview()
            }
        default:
            return
        }
        for obj in self.emojiChildren {
            addSubview(obj.view)
        }
    }
    private func buildContinueTheThought() {
        switch state {
        case .addTitle:
            for obj in self.titleChildren {
                obj.view.removeFromSuperview()
            }
        case .addEmoji:
            for obj in self.emojiChildren {
                obj.view.removeFromSuperview()
            }
        default:
            return
        }
        for obj in self.continueTheThoughtChildren {
            addSubview(obj.view)
        }
    }
}

extension DrawerView {
    func buildDrawer() {
        self.backgroundColor = UIColor(hex: "5066E3")
        for obj in self.closedChildren {
            addSubview(obj.view)
        }
        print("added drawer to superview")
    }
}

