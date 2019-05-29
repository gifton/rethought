
// all preview objects conform to entrybuilder
protocol EntryBuilder {
    var type: EntryType { get set }
    var entry: Entry? { get set }
}

