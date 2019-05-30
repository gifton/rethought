//
//  HomeController.swift
//  Rethought
//
//  Created by Dev on 5/14/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        print("view appeared! thought count: \(model.thoughtCount)")
        // test this
        model.refresh()
        homeHead?.thoughtCollection.reloadData()
        tv?.tv.reloadData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var animator = ViewAnimator()
    var model: HomeViewModel! {
        didSet {
            setView()
        }
    }
    var homeHead: HomeHead?
    var tv: HomeTable?
    lazy var tableButtonMoreView: UIView = UIView()
    
    func setView() {
        tv = HomeTable(frame: CGRect(x: 0, y: 500, width: Device.size.width, height: Device.size.height - 500))
        tv?.tv.dataSource = self
        tv?.animator = self
        
        homeHead = HomeHead(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: 500))
        homeHead?.thoughtCollection.dataSource = self
        homeHead?.thoughtCollection.delegate = self
        view.addSubview(homeHead!)
        view.addSubview(tv!)
    }
    
}
extension HomeController: Animator {
    func didUpdate() {
        let progress = tv?.animationProgress ?? 1
        homeHead?.update(toAnimationProgress: progress)
    }
    
    // option view is displayed for specific thoughts or entries
    func show(optionsFor entry: Entry) {
        
        tabBarController?.tabBar.isHidden = true
        let optionView = ShowOptionsView(frame: CGRect(x: 0, y: Device.size.height + 225, width: Device.size.width, height: 225), options: [.delete, .toEntry, .toThought])
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: Device.size.height - optionView.height))
        newView.blurBackground(type: .dark, cornerRadius: 0)
        newView.layer.opacity = 0
        view.addSubview(newView)
        
        self.view.addSubview(optionView)
        let end = {
            optionView.removeFromSuperview()
            newView.removeFromSuperview()
            self.tabBarController?.tabBar.isHidden = false
        }
        
        newView.addTapGestureRecognizer { end() }
        optionView.cancelButton.addTapGestureRecognizer { end() }
        
        // move newView, show blurr over rest of view
        UIView.animate(withDuration: 0.3) {
            optionView.frame.origin.y -= 225 * 2
            newView.layer.opacity = 0.55
        }
    }
    func register(_ view: Animatable) {
        animator.register(animatableView: view)
    }
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableCell = tableView.dequeueReusableCell(withClass: HomeTableCell.self, for: indexPath)
        cell.setButtonTargets { (entry) in
            self.show(optionsFor: entry)
        }
        cell.insert(payload: model.entries[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.entryCount
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.thoughtCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ThoughtCollectionCell.self, for: indexPath)
        let preview = model.thoughts[indexPath.row].preview
        cell.addContext(preview)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected thought: \(model.thoughts[indexPath.row].title).")
        
        let attrs = collectionView.layoutAttributesForItem(at: indexPath)
        let cellFrameInSuperview = collectionView.convert(attrs?.frame ?? .zero, to: collectionView.superview)
        
        let newView = UIView(frame: cellFrameInSuperview)
        newView.backgroundColor = .blue
        view.addSubview(newView)
        newView.addTapGestureRecognizer {
            newView.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 0.5) {
            newView.frame = self.view.frame
        }
    }
}
