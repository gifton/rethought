
enum EntryType: String, Codable {
    case note = "TEXT"
    case image = "IMAGE"
    case link = "LINK"
    case recording = "RECORDING"
    case all = "ALL"
    
    static func exhaustiveList() -> [EntryType] {
        return [note, image, link, recording, all]
    }
}


protocol EntryBuilder {
    var type: EntryType { get set }
}
