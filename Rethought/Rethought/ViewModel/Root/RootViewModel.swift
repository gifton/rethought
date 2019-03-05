//
//  RootViewmodel.swift
//  rethought
//
//  Created by Dev on 2/27/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RootViewModel: NSObject, RootViewModelDelegate {
    
    init(with moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
        print("RootViewModel set")
        retrieveContent()
    }
    
    var entryPreviews: [EntryPreview] {
        get {
            var output = [EntryPreview]()
            for entry in entries {
                let e = EntryPreview(entry: entry)
                output.append(e)
            }
            
            return output
        }
    }
    
    func getThoughts() -> [ThoughtPreview] {
        var thoughts = [ThoughtPreview]()
        print("COUNT: \(self.thoughts.count)")
        print("====")
        for thought in self.thoughts {
            let t = ThoughtPreview(thought: thought)
            thoughts.append(t)
        }
        return thoughts
    }
    
    func retrieve(thought id: String) -> Thought? {
        return thoughts.filter{ $0.id == id }.first ?? nil
    }
    
    func retrieve(entry id: String) -> Entry? {
        return entries.filter{ $0.id == id }.first ?? nil
    }
    
    // MARK: Private vars
    private var thoughts: [Thought] = [Thought]()
    private var entries: [Entry] = [Entry]()
    
    private var moc: NSManagedObjectContext!
    
}

extension RootViewModel {
    private func retrieveContent() {
        let request = Thought.sortedFetchRequest
        print("recieving core data stack...")
        do {
            let result = try moc.fetch(request)
            self.thoughts = result
            for thought in result {
                for ent in thought.entries {
                    self.entries.append(ent)
                }
            }
        } catch let err {
            print("there was an error fetching: \(err)")
        }
    }
}

extension RootViewModel: UICollectionViewDelegate { }
extension RootViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EntryCell.identifier, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}

extension RootViewModel: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 250
        default:
            return 205
        }
    }
}
extension RootViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(thoughts.count)
        return thoughts.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RootEntryViewCell.identifier, for: indexPath) as! RootEntryViewCell
            cell.setCollectionView(with: self)
            cell.backgroundColor = UIColor(hex: "F9F9F9")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RootEntriesContentCell.identifier, for: indexPath) as! RootEntriesContentCell
            cell.backgroundColor = UIColor(hex: "F9F9F9")
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: RootThoughtCell.identifier, for: indexPath) as! RootThoughtCell
//            if let thought: Thought = thoughts[indexPath.row] {
//                cell.set(with: ThoughtPreview(thought: thought))
//            } else {
//                cell.set(with: ThoughtPreview(thought: thoughts.first!))
//            }
            
            return cell
        }
    }
    
    
}
