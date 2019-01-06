//
//  NewThoughtController.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class NewThoughtController: UIViewController {
    public var nView: NewThoughtView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
    }
    private var delegate: HomeViewControllerDelegate?
    
    public func configure(_ delegate: HomeViewControllerDelegate) {
        self.delegate = delegate
    }
    public func setView(delegate: HomeViewControllerDelegate, icon: String) {
        let frame = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 100, width: ViewSize.SCREEN_WIDTH, height: 675)
        self.nView = NewThoughtView(frame: frame, delegate: delegate, icon: ThoughtIcon(icon))
        self.view = nView!
        nView?.setRecentThought()
    }
    
    
}
extension NewThoughtController: NewThoughtDelegate {
    
    func save(_ thought: Thought) {
        print("context saved: \(thought)")
    }
    
    var thoughtState: NewThoughtView.NewThoughtViewState {
        get {
            return nView!.state
        }
        set {
            guard let delegate = self.delegate else { return }
            delegate.userDidTapNewThought()
        }
    }
    
    
}
