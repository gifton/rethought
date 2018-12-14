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

class TextEntryPreview: UITableViewCell, EntryPreviewCellDelegate {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var title: String {
        get {
            return "hmm"
        }
        set {
            print ("hmmm")
        }
    }
    
    var date: String {
        get {
            return "hmm"
        }
        set {
            print ("hmmm")
        }
    }
    
    var type: Entry.EntryType {
        get {
            return .image
        }
        set {
            print ("hmmm")
        }
    }
    
    public static var identifier: String {
        return "TextEntryPreview"
    }
}
