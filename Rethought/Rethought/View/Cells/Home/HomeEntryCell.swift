//
//  HomeEntryCell.swift
//  Rethought
//
//  Created by Dev on 6/14/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeEntryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCell()
    }
    
    // MARK: private objects
    private let cell = UIView()
    private let moreBtn = UIButton()
    private var entry: Entry?
    private let typeImage = UIImageView()
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()
    
    // set cell views
    func setCell() {
        addSubview(cell)
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .white
        cell.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingBottom: 5, paddingTrailing: 10)
        setViews()
    }
    
    // add entry to cell
    public func insert(payload entry: Entry) {
        self.entry = entry
        dateLabel.getStringFromDate(date: entry.date, withStyle: .medium)
        
        // depending on entry type, set text label
        switch entry.type {
        case EntryType.link.rawValue:
            typeImage.image = #imageLiteral(resourceName: "compass_gradient")
            titleLabel.text = entry.link?.url
        case EntryType.note.rawValue:
            typeImage.image = #imageLiteral(resourceName: "note_gradient")
            titleLabel.text = entry.note?.title
        case EntryType.photo.rawValue:
            typeImage.image = #imageLiteral(resourceName: "Image_gradient")
            titleLabel.text = entry.photo?.detail
        case EntryType.recording.rawValue:
            typeImage.image = #imageLiteral(resourceName: "microphone_gradient")
            titleLabel.text = entry.recording?.detail
        default:
            print("cell image set to: nil")
            return
        }
        
        // add views
        cell.addSubview(typeImage)
        cell.addSubview(titleLabel)
        cell.addSubview(dateLabel)
        
        // place views
        typeImage.translatesAutoresizingMaskIntoConstraints = false
        typeImage.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        typeImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 25).isActive = true
        
        titleLabel.setAnchor(top: cell.topAnchor, leading: typeImage.trailingAnchor, bottom: nil, trailing: moreBtn.leadingAnchor, paddingTop: 25, paddingLeading: 10, paddingBottom: 0, paddingTrailing: 25)
        
        dateLabel.setAnchor(top: titleLabel.bottomAnchor, leading: typeImage.trailingAnchor, bottom: bottomAnchor, trailing: moreBtn.leadingAnchor, paddingTop: -10, paddingLeading: 10, paddingBottom: 20, paddingTrailing: 25)
        
        // style views
        titleLabel.font = Device.font.body(ofSize: .large)
        titleLabel.textColor = Device.colors.darkGray
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        dateLabel.font = Device.font.title(ofSize: .large)
        dateLabel.textColor = Device.colors.darkGray
        
        typeImage.setHeightWidth(width: 30, height: 30)
        typeImage.contentMode = .scaleAspectFit
        
        
    }
    
    // external insertion of method to more btn
    public func setButtonTargets(_ action: @escaping (_ entry: Entry) -> Void) {
        moreBtn.addTapGestureRecognizer {
            action(self.entry!)
            self.moreBtn.addBounceAnimation()
        }
        moreBtn.doesEnable()
    }
    
    private func setViews() {
        cell.addSubview(moreBtn)
        
        moreBtn.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        moreBtn.frame = CGRect(x: frame.width + 25, y: 30, width: 10, height: 30)
    }
    
    static var identifier: String {
        return "HomeTableCellV1"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
