//
//  ThinkViewModel.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import SwiftLinkPreview
import CoreData

class ThinkViewModel: NSObject {
    init(with moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    var moc: NSManagedObjectContext {
        didSet {
            print("yay!")
        }
    }
    
    public var controller: ThinkViewController?
}

extension ThinkViewModel: ThinkViewModelDelegate {
    func initiateThought(_ title: String, icon: ThoughtIcon, completion: () -> Void) {
        let thought = Thought(moc: moc)
        thought.createThought(title: title, icon: icon)
        completion()
        save()
    }
    
    private func save() {
        do {
            try moc.save()
        } catch let err {
            print(err)
        }
    }
}
