//
//  ArrayExtension.swift
//  rethought
//
//  Created by Dev on 1/8/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import Foundation

//+ Operator definition for Dictionary types

func + <K, V> (left: [K: V], right: [K: V]) -> [K: V] {
    var merge = left
    for (k, v) in right {
        merge[k] = v
    }
    return merge
}

func += <K, V> (left: inout [K: V], right: [K: V]) {
    left += right
}

func + <F> (consumer: inout [F], data: [F]) {
    for d in data {
        consumer.append(d)
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral {
    
    mutating func lowercaseKeys() {
        for key in self.keys {
            if let loweredKey = String(describing: key).lowercased() as? Key {
                self[loweredKey] = self.removeValue(forKey: key)
            }
        }
    }
}
