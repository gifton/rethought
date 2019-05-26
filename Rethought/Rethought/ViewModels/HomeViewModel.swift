//
//  HomeViewModel.swift
//  Rethought
//
//  Created by Dev on 5/21/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class HomeViewModel: NSObject {
    init(withmoc moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
        setup()
    }
    
    private var moc: NSManagedObjectContext
    var entries = [Entry]() {
        didSet {
            print("did set entries")
        }
    }
    public var thoughtCount: Int {
        get { return self.thoughts.count }
    }
    public var entryCount: Int {
        return thoughts.entries().count
    }
    public var thoughts: [Thought] = [] {
        didSet {
            print("thoughts set")
        }
    }
    
    private func setup() {
        thoughts = fetchThoughts()
        entries = thoughts.entries()
    }
}

extension HomeViewModel {
    func fetchThoughts() -> [Thought] {
        print("begining fetch request from HomeModel")
        let request = Thought.fetchRequest()
        do {
            let result = try moc.fetch(request)
            guard let castedThoughts: [Thought] = result as? [Thought] else {
                print("unable to cast thoughts from result in fetchrequest")
                return thoughts
            }
            return castedThoughts
        } catch let err {
            print("there was an error fetching: \(err)")
        }
        fatalError("fwk")
    }
}
