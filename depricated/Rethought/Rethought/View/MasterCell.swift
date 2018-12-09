//
//  DashboardCell.swift
//  CareTake
//
//  Created by Dev on 11/17/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MasterCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundAccentGray
        
    }
    
    var date = UILabel()
    let line = UIView()
    let painLabel = UILabel()
    let fatigueLabel = UILabel()
    let medicationLabel = UILabel()
    var medication = UILabel()
    var foodEaten = UILabel()
    var symptoms: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = false
        tv.backgroundColor = .clear
        
        return tv
    }()
    
    public class var identifier: String {
        return "MasterCellIdentifier"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
