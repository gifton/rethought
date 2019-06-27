//
//  Optional.swift
//  Rethought
//
//  Created by Dev on 4/25/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation

public extension Optional {
    func getOr(else el:@autoclosure () throws -> Wrapped) rethrows -> Wrapped {
        return try self ?? el()
    }
    
    func getOr(else el:() throws -> Wrapped) rethrows -> Wrapped {
        return try self ?? el()
    }
    
    func or(else el:@autoclosure () throws -> Wrapped?) rethrows -> Wrapped? {
        return try self ?? el()
    }
    
    func or(else el:() throws -> Wrapped?) rethrows -> Wrapped? {
        return try self ?? el()
    }
}
