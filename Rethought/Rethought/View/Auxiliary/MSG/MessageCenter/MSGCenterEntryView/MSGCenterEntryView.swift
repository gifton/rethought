
import Foundation

protocol MSGCenterEntryView {
    var entryType: EntryType { get }
}

protocol EntryComponentBus {
    func save<K: EntryBuilder>(withpayload payload: K)
}
