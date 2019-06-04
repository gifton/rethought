//
//  ThoughtDetailController.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    lazy var headView = ThoughtDetailSearchBar(startFrame: CGRect(x: 0, y: -100, width: Device.size.width, height: 100), endFrame: CGRect(x: 0, y: 0, width: Device.size.width, height: 100), preview: thought)
    var table = ThoughtDetailTable(frame: CGRect(origin: .zero, size: CGSize(width: Device.size.width, height: Device.size.height - 100)))
    var entryBar: ThoughtDetailEntryBar!
    let animationScrollLength: CGFloat = 100.0
    var progress: CGFloat = 0.0 {
        didSet { animator.updateAnimation(toProgress: progress) }
    }
    
    public var model: ThoughtDetailViewModel! {
        didSet { setView() }
    }
    
    public var animator = ViewAnimator()
    
    private func setView() {
        
        // set table delegates and datasources
        table.tv.delegate = self
        table.tv.dataSource = self
        table.tv.register(cellWithClass: ThoughtDetailTableHead.self)
        table.tv.register(cellWithClass: NoteEntryCell.self)
        table.tv.register(cellWithClass: LinkEntryCell.self)
        table.tv.sectionHeaderHeight = 300
        
        headView.delegate = self
        animator.register(animatableView: headView)
        
        view.addSubview(table)
        entryBar = ThoughtDetailEntryBar(withDelegate: self)
        view.addSubview(entryBar)
        view.addSubview(headView)
    }
}

extension ThoughtDetailController: ThoughtDetailDelegate {
    var thought: ThoughtPreview {
        return model.thought.preview
    }
    
    func displayEntryType(_ type: EntryType) -> Bool {
        
        let nView = UIView()
        nView.backgroundColor = .lightGray
        nView.addTapGestureRecognizer { nView.removeFromSuperview() }
        nView.layer.borderColor = UIColor.black.cgColor
        nView.layer.borderWidth = 1
        nView.frame = CGRect(x: 25, y: 200, width: Device.size.width - 50, height: Device.size.width - 50)
        
        view.addSubview(nView)
        return true
    }
    
    func saveEntryWith(builder: EntryBuilder) -> Bool { return true }
    
    func requestClose() {
        navigationController?.popViewController(animated: true)
    }
    
    func delete(entry: Entry) { }
    
    func delete(thought: Thought) { }
    
    func search(for payload: String, completion: () -> ()) { }
    
    func updateIcon(to: String) { }
    
}


extension ThoughtDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  model.cellFor(index: indexPath, tableView: tableView) else {
            print("unable to register cell from controller model method call")
            return UITableViewCell()
        }
        
        // register cell as animateable only if it is
        if let conformedCell = cell as? Animatable {
            animator.register(animatableView: conformedCell)
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let scroll = scrollView as? UITableView {
            if scroll.numberOfRows(inSection: 0) >= 4 {
                let offset = scroll.contentOffset.y
                let normalizedOffset = max(0.0, min(1.0, offset/animationScrollLength))
                self.progress = normalizedOffset
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model.heightFor(row: indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.entryCount.total
    }
}
