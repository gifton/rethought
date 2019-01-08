//
//  Drawer.swift
//  rethought
//
//  Created by Dev on 1/6/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DrawerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildDrawer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var position: DrawerPosition = .collapsed
    var state: DrawerState = .closed
    
    var objectSource: DrawerObjectSource?
    var updateSize: HomeViewControllerDelegate?
    
    private var closedViews:             [DrawerChild] = []
    private var beginThoughtViews:       [DrawerChild] = []
    private var titleViews:              [DrawerChild] = []
    private var emojiViews:              [DrawerChild] = []
    private var continueTheThoughtViews: [DrawerChild] = []
    let btn = UIButton(frame: CGRect(x: 25, y: 25, width: 100, height: 30))
    
}

extension DrawerView: DrawerDelegate {
    public func change(position to: DrawerPosition) {
        guard let updateSize = updateSize else { return }
        updateSize.drawerRequests(state: to)
    }
    
    public func change(state to: DrawerState) {
        switch to {
        case .addEmoji:
            change(position: .open)
            print("emoji!")
        case .addTitle:
            change(position: .open)
            print("title")
        case .beginThought:
            change(position: .mini)
            print("begning")
        case .closed:
            change(position: .collapsed)
            print("closed")
        case .continueTheThought:
            change(position: .medium)
        }
        
    }
}

extension DrawerView: DrawerObjectSource {
    var continueTheThoughtChildren: [DrawerChild] {
        get {
            return self.continueTheThoughtViews
        }
        set {
            self.continueTheThoughtViews = newValue
        }
    }
    
    var closedChildren: [DrawerChild] {
        get {
            return self.closedViews
        }
        set {
            self.closedViews = newValue
            guard let position = newValue.first?.state else { return }
            self.change(state: position)
        }
    }
    
    var beginThoughtCildren: [DrawerChild] {
        get {
            return beginThoughtViews
        }
        set {
            self.beginThoughtViews = newValue
            guard let position = newValue.first?.state else { return }
            self.change(state: position)
        }
    }
    
    var titleChildren: [DrawerChild] {
        get {
            return titleViews
        }
        set {
            self.titleViews = newValue
            guard let position = newValue.first?.state else { return }
            self.change(state: position)
        }
    }
    
    var emojiChildren: [DrawerChild] {
        get {
            return emojiViews
        }
        set {
            self.emojiViews = newValue
            guard let position = newValue.first?.state else { return }
            self.change(state: position)
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
            for view in beginThoughtViews {
                view.removeFromSuperview()
            }
        case .continueTheThought:
            for view in continueTheThoughtViews {
                view.removeFromSuperview()
            }
        default:
            return
        }
    }
    private func buildBeginThoughtView() {
        switch state {
        case .closed:
            for view in beginThoughtViews {
                addSubview(view)
            }
        case .addEmoji:
            for view in emojiViews {
                view.removeFromSuperview()
            }
        case .addTitle:
            for view in titleViews {
                view.removeFromSuperview()
            }
        default:
            return
        }
    }
    private func buildThoughtTitleView() {
        switch state {
        case .beginThought:
            for view in beginThoughtViews {
                view.removeFromSuperview()
            }
        default:
            return
        }
    }
    private func buildThoughtEmojiView() {
        switch state {
        case .beginThought:
            for view in beginThoughtViews {
                view.removeFromSuperview()
            }
        default:
            return
        }
    }
    private func buildContinueTheThought() {
        switch state {
        case .addTitle:
            for view in titleViews {
                view.removeFromSuperview()
            }
        case .addEmoji:
            for view in emojiViews {
                view.removeFromSuperview()
            }
        default:
            return
        }
    }
}

extension DrawerView {
    func buildDrawer() {
        self.backgroundColor = UIColor(hex: "5066E3")
        btn.setTitle("Next", for: .normal)
        addSubview(btn)
        btn.addTarget(self, action: #selector(changeDrawer(_:)), for: .touchUpInside)
    }
    
    @objc
    func changeDrawer(_ sender: UIButton) {
        switch position {
        case .collapsed:
            change(position: .mini)
            self.position = .mini
        case .mini:
            change(position: .open)
            self.position = .open
        case .open:
            change(position: .medium)
            self.position = .medium
        case .medium:
            change(position: .collapsed)
            self.position = .collapsed
        }
    }
}
