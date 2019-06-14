
import Foundation
import UIKit

// passing data from home head and home table to controller
protocol HomeDelegate {
    func show(entryForIndex row: Int)
    func didSelectEntryType(ofType type: EntryType)
    func didChangeFilterDirection(toDirecton direction: FilterDirection)
}

// passing homeContentPackage data between head and table views and controller
protocol HomeContentPackageReciever {
    func updatepackage(withContent content: HomeContentPackage)
}

// updating home head and table from model
struct HomeContentPackage {
    var title: String
    var entryType: EntryType
    var filterDirection: FilterDirection
}

