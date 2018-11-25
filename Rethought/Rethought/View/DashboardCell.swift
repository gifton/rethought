//
//  DashboardCell.swift
//  CareTake
//
//  Created by Dev on 11/17/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DashboardCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
//        setupViews()
        self.layer.cornerRadius = 10
    }
    
    var date = UILabel()
    let line = UIView()
    let painLabel = UILabel()
    let fatigueLabel = UILabel()
//    var pain = LargeDisplay(pain: 8, frame: CGRect(x: 20, y: 100, width: 100, height: 100))
//    var fatigue = LargeDisplay(pain: 4, frame: CGRect(x: (ScreenSize.SCREEN_WIDTH - 20) - 120, y: 100, width: 100, height: 100))
    let medicationLabel = UILabel()
    var medication = UILabel()
    var foodEaten = UILabel()
    var symptoms: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = false
        tv.backgroundColor = .clear
        
        return tv
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupViews() {
//        addSubview(date)
//        addSubview(line)
//        addSubview(painLabel)
////        addSubview(pain)
//        addSubview(fatigueLabel)
//        addSubview(fatigue)
//        addSubview(medicationLabel)
//        addSubview(medication)
//
//        date.translatesAutoresizingMaskIntoConstraints = false
//        date.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
//        date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//
//        line.translatesAutoresizingMaskIntoConstraints = false
//        line.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 10).isActive = true
//        line.setHeightWidth(width: ScreenSize.SCREEN_WIDTH - 25, height: 3)
//
//        painLabel.translatesAutoresizingMaskIntoConstraints = false
//        painLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10).isActive = true
//        painLabel.centerXAnchor.constraint(equalTo: pain.centerXAnchor).isActive = true
//
//        fatigueLabel.translatesAutoresizingMaskIntoConstraints = false
//        fatigueLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10).isActive = true
//        fatigueLabel.centerXAnchor.constraint(equalTo: fatigue.centerXAnchor).isActive = true
//
//        medicationLabel.translatesAutoresizingMaskIntoConstraints = false
//        medicationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//        medicationLabel.topAnchor.constraint(equalTo: pain.bottomAnchor, constant: 25).isActive = true
//
//        medication.translatesAutoresizingMaskIntoConstraints = false
//        medication.topAnchor.constraint(equalTo: pain.bottomAnchor, constant: 45).isActive = true
//        medication.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//
//        standardStyling()
//    }
//
//    func standardStyling() {
//        date.font = UIFont(name: "HelveticaNeue-bold", size: fontSize.xXXLarge.rawValue)
//        date.textColor = .white
//        date.text = "March 24th, 2018"
//
//        painLabel.text = "Pain"
//        painLabel.font = UIFont(name: "HelveticaNeue-bold", size: fontSize.large.rawValue)
//        painLabel.textColor = .white
//
//        fatigueLabel.text = "Fatigue"
//        fatigueLabel.font = UIFont(name: "HelveticaNeue-bold", size: fontSize.large.rawValue)
//        fatigueLabel.textColor = .white
//
//        line.backgroundColor = UIColor(hex: "0E253D")
//
//        medicationLabel.font = UIFont(name: "HelveticaNeue-bold", size: fontSize.xLarge.rawValue)
//        medicationLabel.textColor = .white
//        medicationLabel.text = "Medication taken today"
//
//        medication.textColor = .darkGray
//        medication.font = UIFont(name: "HelveticaNeue", size: fontSize.xLarge.rawValue)
//        medication.numberOfLines = 3
//        medication.text = "Promethazene\nCodiene\nXanax"
//    }
}
