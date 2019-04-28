
enum EntryType: String, Codable {
    case note = "TEXT"
    case photo = "PHOTO"
    case link = "LINK"
    case recording = "RECORDING"
    case all = "ALL"
    
    static func exhaustiveList() -> [EntryType] {
        return [note, note, link, recording, all]
    }
}


protocol EntryBuilder {
    var type: EntryType { get set }
}
