
import Foundation

// all preview objects conform to entrybuilder
protocol EntryBuilder {
    var type: EntryType { get set }
    var entry: Entry? { get set }
    var thoughtIcon: ThoughtIcon { get set }
    var date: Date { get set }
    static var zero: EntryBuilder { get }
}
