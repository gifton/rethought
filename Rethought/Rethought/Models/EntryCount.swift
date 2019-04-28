import Foundation

struct EntryCount {
    var text:      String
    var photo:     String
    var link:      String
    var recording: String
    var total:     Int
    
    init(text: Int, photos: Int, recordings: Int, links: Int) {
        self.text = "\(text) text"
        self.photo = "\(photos) photos"
        self.link = "\(links) images"
        self.recording = "\(recordings) recordings"
        self.total = text + photos + recordings + links
    }
}
