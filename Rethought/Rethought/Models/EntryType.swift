
// all available entryTypes
enum EntryType: String, Codable {
    case note = "NOTE"
    case photo = "PHOTO"
    case link = "LINK"
    case recording = "RECORDING"
    case all = "ALL"
    case none = "NONE"
    
    static func exhaustiveList() -> [EntryType] {
        return [note, photo, link, recording, all]
    }
}
