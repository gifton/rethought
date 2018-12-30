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
        //other wise runtime error may occur because of delayed reciept of data, or missing data
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

    let thoughtLabel: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 15, y: 50, width: 100, height: 30))
        img.image = #imageLiteral(resourceName: "Logo")
        
        return img
    }()

    let reccomendedThoughtLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 15, y: 85, width: ViewSize.SCREEN_WIDTH - 150, height: 40))
        lbl.text = "🚂 CONTINUE THE THOUGHT"
        lbl.font = UIFont(name: "Lato-Bold", size: 16)
        lbl.textColor = UIColor(hex: "BFC0C3")
        return lbl
    }()
    let viewAllThoughtsButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 95, y: 87, width: 80, height: 30))
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Light", size: 14),  NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let myAttrString = NSAttributedString(string: "View all", attributes: attribute as [NSAttributedString.Key : Any])
        btn.setAttributedTitle(myAttrString, for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        return btn
    }()
    let viewAllEntriesButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 120, y: 180, width: 180, height: 20))
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
        let cv = UICollectionView(frame: CGRect(x: 0, y: 130, width: ViewSize.SCREEN_WIDTH, height: 50), collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    var recentEntryTable: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 185, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 285))
        tv.allowsSelection = false
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        
        return tv
    }()
    
    let recentEntriesLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 15, y: 380, width: 180, height: 20))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "🎯 RECENT ENTRIES"
        lbl.font = UIFont(name: "Lato-Bold", size: 16)
        lbl.textColor = UIColor(hex: "BFC0C3")
        return lbl
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
        addSubview(quickAddView)
        addSubview(viewAllThoughtsButton)
        
        setupTables()
        recentThoughtsCollectionView.reloadData()
        
        profileButton.addTarget(self, action: #selector(userPressedProfile), for: .touchUpInside)
        viewAllThoughtsButton.addTarget(self, action: #selector(userPressedViewAllThoughts), for: .touchUpInside)
    }
    
    func setupTables() {
        recentThoughtsCollectionView.register(MicroThoughtCell.self, forCellWithReuseIdentifier: MicroThoughtCell.identifier)
        recentThoughtsCollectionView.delegate = self
        recentThoughtsCollectionView.dataSource = self
        
        recentEntryTable.register(TextEntryCell.self, forCellReuseIdentifier: TextEntryCell.identifier)
        recentEntryTable.register(ImageEntryCell.self, forCellReuseIdentifier: ImageEntryCell.identifier)
        recentEntryTable.register(RecommendedThoughtCell.self, forCellReuseIdentifier: RecommendedThoughtCell.identifier)
        recentEntryTable.delegate = self
        recentEntryTable.dataSource = self
    }
}

extension HomeView {
    public func dataIsLoaded() {
        self.updateViews()
    }
    private func updateViews() {
        self.reloadInputViews()
        self.recentThoughtsCollectionView.reloadData()
        
    }
}

extension HomeView {
    @objc func userPressedProfile() {
        print("we made it to this objc func!")
        delegate?.userDidTapProfileButton()
    }
    @objc func userPressedViewAllThoughts() {
        print("we made it to this objc func!")
        delegate?.userDidTapViewAllThoughts()
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
