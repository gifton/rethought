import Foundation

struct EntryCount {
    var notes:      String
    var photo:     String
    var link:      String
    var recording: String
    var total:     Int
    
    init(notes: Int, photos: Int, recordings: Int, links: Int) {
        self.notes = "\(notes) text"
        self.photo = "\(photos) photos"
        self.link = "\(links) images"
        self.recording = "\(recordings) recordings"
        self.total = notes + photos + recordings + links
    }
}
