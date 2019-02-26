//
//  PersistanceService.swift
//  rethought
//
//  Created by Dev on 2/1/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersistanceService {
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RETHOUGHT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


func createThoughtContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    print("one")
    let container = NSPersistentContainer(name: "RETHOUGHT")
    container.loadPersistentStores { (_, error) in
        print("two")
        guard error == nil else { fatalError("failed to load store: \(error!)")}
        DispatchQueue.main.async {
            print("Three")
            completion(container)
        }
    }
    print("four")
}
