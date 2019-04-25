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
