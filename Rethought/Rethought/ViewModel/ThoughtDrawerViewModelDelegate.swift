//
//  ThoughtDrawerViewModelDelegate.swift
//  rethought
//
//  Created by Dev on 1/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation


protocol ThoughtDrawerViewModelDelegate {
    func save(new thought: Thought)
    func createThought(title: String, description: String?)
    func save(new thought: ThoughtDrawerViewModel, with: Entry)
    func buildRecent(string input: Date) -> String
}

protocol DrawerObjectFactory {
    func convertToDrawerObject(_ view: UIView, availableIn states: [DrawerState]) -> DrawerObject
}
