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
    
    //homeview needs thoughts object to display most current Thoughts, and recent entries
    public var thoughts: [Thought]?
    public var thoughtCount: Int?
    public var delegate: HomeViewControllerDelegate?
    public var reccomendedThought: ThoughtPreviewLarge?
    public var recentThoughts: [ThoughtPreviewSmall]?
    public var recentEntries: [EntryPreview]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "FAFBFF")
        
    }
    convenience init(_ recentThoughts: [ThoughtPreviewSmall],
                     _ reccomendedThought: ThoughtPreviewLarge,
                     _ recentEntries: [EntryPreview],
                     delegate: HomeViewControllerDelegate,
                     thoughtCount: Int, frame: CGRect) {
        self.init(frame: frame)
        self.delegate = delegate
        self.thoughtCount = thoughtCount
        self.recentThoughts = recentThoughts
        self.reccomendedThought = reccomendedThought
        self.recentEntries = recentEntries
        //call setView in conveniance init, because conveniance init includes the neccesary components
        setView()
        
    }
    //MARK: All objects in homeView
    let profileButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 80, y: 57, width: 60, height: 20))
        btn.setTitle("Profile", for: .normal)
        btn.setTitleColor(UIColor(hex: "E91E63"), for: .normal)
        
        return btn
    }()
    let quickAddView = QuickAddView(frame: CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 100, width: ViewSize.SCREEN_WIDTH, height: 100))

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

    let reccomendedThoughtLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 15, y: 85, width: ViewSize.SCREEN_WIDTH - 150, height: 40))
        lbl.text = "🚂 CONTINUE THE THOUGHT"
        lbl.font = UIFont(name: "Lato-Bold", size: 16)
        lbl.textColor = UIColor(hex: "BFC0C3")
        return lbl
    }()
    let viewAllThoughtsButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 100, y: 10, width: 80, height: 30))
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Light", size: 14),  NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let myAttrString = NSAttributedString(string: "View all", attributes: attribute as [NSAttributedString.Key : Any])
        btn.setAttributedTitle(myAttrString, for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        return btn
    }()
    var recentThoughtsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = ViewSize.thoughtCellSmall
        let cv = UICollectionView(frame: CGRect(x: 0, y: 110, width: ViewSize.SCREEN_WIDTH, height: 50), collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    var recentEntryTable: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 180, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 200))
        
        return tv
    }()
    
    let newThoughtButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 15, y: 148, width: ViewSize.SCREEN_WIDTH - 30, height: 55))
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Regular", size: 20),  NSAttributedString.Key.foregroundColor: UIColor.white]
        let myAttrString = NSAttributedString(string: "Create new Thought", attributes: attribute as [NSAttributedString.Key : Any])
        btn.setAttributedTitle(myAttrString, for: .normal)
        btn.backgroundColor = UIColor(hex: "2ECD95")
        btn.layer.cornerRadius = 4
        
        return btn
    }()
    let recentEntriesLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "🎯 RECENT ENTRIES"
        lbl.font = UIFont(name: "Lato-Bold", size: 16)
        lbl.textColor = UIColor(hex: "BFC0C3")
        return lbl
    }()
    let reccomendedThoughtView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "55AFF8")
        
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setView() {
        addSubview(thoughtLabel)
        addSubview(profileButton)
        addSubview(quickAddView)
        addSubview(reccomendedThoughtLabel)
        addSubview(recentThoughtsCollectionView)
        addSubview(recentEntryTable)
        
        setupTables()
        recentThoughtsCollectionView.reloadData()
        
        profileButton.addTarget(self, action: #selector(userPressedProfile), for: .touchUpInside)
        newThoughtButton.addTarget(self, action: #selector(userPressedNewThought), for: .touchUpInside)
    }
    
    func setupTables() {
        recentThoughtsCollectionView.register(MicroThoughtCell.self, forCellWithReuseIdentifier: MicroThoughtCell.identifier)
        recentThoughtsCollectionView.delegate = self
        recentThoughtsCollectionView.dataSource = self
        
        recentEntryTable.register(EntryPreviewCell.self, forCellReuseIdentifier: EntryPreviewCell.identifier)
        recentEntryTable.delegate = self
        recentEntryTable.dataSource = self
    }
//
//    func addRecentEntries() {
//        var origin = CGPoint(x: 12, y: 250)
//
//        for (count, entry) in recentEntries!.enumerated() {
//            let newFrame = CGRect(x: origin.x, y: origin.y, width: ViewSize.minimumEntryPreviewSize.width, height: ViewSize.minimumEntryPreviewSize.height)
//            //depending on the type, produce a view that translates
//            switch entry.type {
//            case .image:
//                //display first image in entry
//                //consider doing a collage of images if > 1 in future?
//                let newEntry = EntryImageView(entry, frame: newFrame, delegate: self.delegate)
//                scrollView.addSubview(newEntry)
//                origin.y += (entry.images.first?.size.height)! + 35
//
//            case .text:
//                let newEntry = EntryTextView(entry.title,
//                                             entry.description ?? "Details not available",
//                                             "\(count) days", frame: newFrame)
//                scrollView.addSubview(newEntry)
//                origin.y += ViewSize.minimumEntryPreviewSize.height + 10
//
//            case .link:
//                let newEntry = EntryTextView(entry.title,
//                                             entry.description ?? "Details not available",
//                                             "\(count) days", frame: newFrame)
//                scrollView.addSubview(newEntry)
//                origin.y += ViewSize.minimumEntryPreviewSize.height + 20
//
//            }
//        }
//    }
}

extension HomeView {
    public func dataIsLoaded() {
        self.updateViews()
    }
    private func updateViews() {
        self.reloadInputViews()
        self.recentThoughtsCollectionView.reloadData()
        
    }
    private func calculateScrollViewHeight() -> CGFloat {
        var height: CGFloat = 600
        if self.recentEntries?.count ?? 0 > 0 {
            for entry in recentEntries! {
                switch entry.type {
                case .image:
                    height += ((entry.images.first?.size.height)!)
                case .text:
                    height += 120
                case .link:
                    height += 70
                }
            }
        }
        print("---------", height)
        height += 50
        return height
    }
}

extension HomeView {
    @objc func userPressedProfile() {
        print("we made it to this objc func!")
        delegate?.userDidTapProfileButton()
    }
    @objc func userPressedViewAllThoughts() {
        print("we made it to this objc func!")
        delegate?.userDidTapProfileButton()
    }
    @objc func userPressedNewThought() {
        print("we made it to this objc func!")
        delegate?.userDidTapNewThought()
    }
    @objc func userPressedViewAllEntries() {
        print("we made it to this objc func!")
        delegate?.userDidTapProfileButton()
    }
    @objc func userPressedOnEntry(_ id: String?) {
        print ("this actually worked lmao")
    }
    
}
