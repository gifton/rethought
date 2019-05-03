
import Foundation

protocol MSGCenterEntryView {
    var entryType: EntryType { get }
    var minimumComponentsCompleted: Bool { get }
}

protocol EntryComponentBus {
    func save<K: EntryBuilder>(withpayload payload: K)
}
