//
//  DashboardView.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DashboardView: UIView {
    var objs: [NSManagedObject] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGradientToView(view: self)
        
        mainLabel.frame = CGRect(x: 25, y: 200, width: 200, height: 25)
        mainLabel.layer.borderWidth = 2
        mainLabel.backgroundColor = .mainBlue
        
        mainButton.frame = CGRect(x: 25, y: 250, width: 200, height: 45)
        mainButton.addTarget(self, action: #selector(checkIfSaved(_:)), for: .touchUpInside)
        mainButton.setImage(.random(), for: .normal)
        
        addSubview(mainLabel)
        addSubview(mainButton)
    }
    
    var mainLabel = UILabel()
    var mainButton = UIButton()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DashboardView {
    @objc
    func checkIfSaved(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ThoughtModel")
        userFetch.fetchLimit = 25
        userFetch.resultType = .managedObjectResultType
        
        do {
            let testResults = try managedContext.fetch(userFetch) as! [ThoughtModel]
            for result in testResults {
                print(result.entryModel)
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func addGradientToView(view: UIView) {
        //gradient layer
        let gradientLayer = CAGradientLayer()
        
        //define colors
        gradientLayer.colors = [UIColor(hex: "F9FCFF").cgColor,UIColor(hex: "DEE0F3").cgColor]
        
        //define locations of colors as NSNumbers in range from 0.0 to 1.0
        //if locations not provided the colors will spread evenly
        gradientLayer.locations = [0.0, 0.6, 0.8]
        
        //define frame
        gradientLayer.frame = ViewSize.FRAME
        
        //insert the gradient layer to the view layer
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
