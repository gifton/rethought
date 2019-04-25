import Foundation

struct EntryCount {
    var text:      String
    var image:     String
    var link:      String
    var recording: String
    var total:     Int
    
    init(text: Int, images: Int, recordings: Int, links: Int) {
        self.text = "\(text) text"
        self.image = "\(images) images"
        self.link = "\(links) images"
        self.recording = "\(recordings) images"
        self.total = text + images + recordings + links
    }
}
