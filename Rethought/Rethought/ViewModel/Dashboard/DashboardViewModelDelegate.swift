//
//  DashboardViewModelDelegate.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardViewModelDelegate {
    func getQuoteOfTheDay() -> QuoteOfTheDayElement
    func getRecentEntries() -> EntryPreview
    func getThoughts() -> [DashboardThought]
    func retrieve(thought id: String) -> Thought
}
