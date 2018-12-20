//
//  EntryPreviewCell.swift
//  rethought
//
//  Created by Dev on 12/13/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol EntryPreviewCellDelegate {
    var title: String { get set }
    var date: String { get set }
    var type: Entry.EntryType { get }
}

class EntryPreviewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .mainRed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var title = UILabel(frame: CGRect(x: 5, y: 10, width: ViewSize.SCREEN_WIDTH - 20, height: 20))
    
    private var body = UILabel(frame: CGRect(x: 5, y: 35, width: ViewSize.SCREEN_WIDTH - 20, height: 60))
    
    public static var identifier: String {
        return "TextEntryPreview"
    }
}
