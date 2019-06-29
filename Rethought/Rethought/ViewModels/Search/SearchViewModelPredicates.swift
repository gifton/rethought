//
//  SearchViewModelPredicates.swift
//  Rethought
//
//  Created by Dev on 6/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension SearchViewModel {
    func createThoughtPredicate(forPayload payload: [String]) -> [NSPredicate] {
        var predicates = [NSPredicate]()
        for word in payload {
            let thoughtTitlePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Thought.title), word)
            let thoughtDatePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Thought.date), word)
            predicates.append(contentsOf: [thoughtTitlePredicate, thoughtDatePredicate])
        }
        return predicates
    }
    
    func createPredicateForLink(withPayload payload: [String]) -> [NSPredicate] {
        var preds = [NSPredicate]()
        
        for word in payload {
            let linkPredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(LinkEntry.url), word)
            let detailPredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(LinkEntry.detail), word)
            let titlePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(LinkEntry.title), word)
            preds.append(contentsOf: [linkPredicate, detailPredicate, titlePredicate])
        }
        
        
        return preds
    }
    
    func createPredicateForNote(withPayload payload: [String]) -> [NSPredicate] {
        var preds = [NSPredicate]()
        for word in payload {
            let detailPredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(NoteEntry.detail), word)
            let titlePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(NoteEntry.title), word)
            
            preds.append(contentsOf: [detailPredicate, titlePredicate])
        }
        
        
        return preds
    }
    
    func createPredicateForPhoto(withPayload payload: [String]) -> [NSPredicate] {
        var preds = [NSPredicate]()
        for word in payload {
            let detailPredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(PhotoEntry.detail), word)
            
            preds.append(detailPredicate)
        }
        
        
        return preds
    }
    
    func createPredicateForRecording(withPayload payload: [String]) -> [NSPredicate] {
        return []
    }
}
