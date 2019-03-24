//
//  EntryTypeView.swift
//  Rethought-project
//
//  Created by Dev on 3/19/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class EntryTypeCollection: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        
        register(cellWithClass: EntryTypeCollectionCell.self)
        
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var rootHeaderDelegate: RootHeaderDelegate?
}

extension EntryTypeCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0,2:
            return CGSize(width: 77, height: 40)
        case 3:
            return CGSize(width: 115, height: 40)
        default:
            return CGSize(width: 96, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rootHeaderDelegate?.showEntry(ofType: EntryType.exhaustiveList()[indexPath.row])
    }
}
extension EntryTypeCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EntryType.exhaustiveList().count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: EntryTypeCollectionCell.self, for: indexPath)
        
        cell.build(EntryType.exhaustiveList()[indexPath.row])
        
        return cell
    }
    
    
}

//shows entry type in collection view
class EntryTypeCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderColor = Device.colors.accentGray.cgColor
        layer.borderWidth = 1
    }
    
    public static var identifier: String {
        return "EntryListViewCell"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mainLabel = UILabel()
    
    public func build(_ text: EntryType) {
        mainLabel = {
            let lbl = UILabel()
            lbl.text = "\(text)"
            lbl.frame = frame
            lbl.font = Device.font.mediumTitle(ofSize: .large)
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            lbl.adjustsFontSizeToFitWidth = true
            
            if text == .all{
                lbl.textColor = .white
                backgroundColor = Device.colors.mainBlue
                layer.borderWidth = 0
            }
            
            return lbl
        }()
        
        addSubview(mainLabel)
        mainLabel.frame.origin = CGPoint(x: 0, y: 0)
    }
    
    override func prepareForReuse() {
        self.removeSubviews()
    }
}
