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
    
    private var currentFrame: CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "FAFBFF")
        self.currentFrame = frame
        
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
    

    let thoughtLabel: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "Logo")
        
        return img
    }()

    let reccomendedThoughtLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "🚂 CONTINUE THE THOUGHT"
        lbl.font = UIFont(name: "Lato-Bold", size: 16)
        lbl.textColor = UIColor(hex: "BFC0C3")
        return lbl
    }()
    let viewAllThoughtsButton: UIButton = {
        let btn = UIButton()
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
        let tv = UITableView()
        tv.allowsSelection = true
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        
        return tv
    }()
    
    let recentEntriesLabel: UILabel = {
        let lbl = UILabel()
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
        addSubview(reccomendedThoughtLabel)
        addSubview(recentThoughtsCollectionView)
        addSubview(recentEntryTable)
        addSubview(viewAllThoughtsButton)
        
        thoughtLabel.frame = CGRect(x: 15, y: 50, width: 100, height: 30)
        reccomendedThoughtLabel.frame = CGRect(x: 15, y: 85, width: ViewSize.SCREEN_WIDTH - 150, height: 40)
        viewAllThoughtsButton.frame = CGRect(x: ViewSize.SCREEN_WIDTH - 95, y: 87, width: 80, height: 30)
        recentEntryTable.frame = CGRect(x: 0, y: 185, width: ViewSize.SCREEN_WIDTH, height: ViewSize.SCREEN_HEIGHT - 285)
        recentEntriesLabel.frame = CGRect(x: 15, y: 380, width: 180, height: 20)
        
        setupTables()
        recentThoughtsCollectionView.reloadData()
        
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
    
    public func shrink() {
       
//        let newFrame = CGRect(x: currentFrame.origin.x + 25, y: currentFrame.origin.y + 55, width: currentFrame.size.width - 50, height: currentFrame.size.height)
//        self.frame = newFrame
        
    }
}

extension HomeView {
    @objc func userPressedViewAllThoughts() {
        print("we made it to this objc func!")
        delegate?.userDidTapViewAllThoughts()
    }
}
