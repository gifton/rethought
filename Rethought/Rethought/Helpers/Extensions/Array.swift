import Foundation
import UIKit

//converts all keys in dict to uppercase
extension Dictionary where Key: ExpressibleByStringLiteral {
    
    mutating func lowercaseKeys() {
        for key in self.keys {
            if let loweredKey = String(describing: key).lowercased() as? Key {
                self[loweredKey] = self.removeValue(forKey: key)
            }
        }
    }
}

//append array to another
func + <F> (consumer: inout [F], data: [F]) {
    for d in data {
        consumer.append(d)
    }
}

//append dict to another
func + <K, V> (left: [K: V], right: [K: V]) -> [K: V] {
    var merge = left
    for (k, v) in right {
        merge[k] = v
    }
    return merge
}

// add two EntryCount objects together
extension EntryCount {
    static func + (_ ec1: EntryCount, _ ec2: EntryCount) -> EntryCount {
        return EntryCount(notes: ec1.noteInt + ec2.noteInt, photos: ec1.photoInt + ec2.photoInt, recordings: ec1.recordingInt + ec2.recordingInt, links: ec1.linkInt + ec2.linkInt)
    }
}

// get all entries from an array of thoughts
extension Sequence where Iterator.Element: Thought {
    func entries() -> [Entry] {
        var entries = [Entry]()
        forEach {entries.append(contentsOf: $0.allEntries)}
        return entries
    }
}

// return array of entries from sequences of 
