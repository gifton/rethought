import Foundation

struct EntryCount {
    var note:      String
    var photo:     String
    var link:      String
    var recording: String
    var total:     Int
    
    init(notes: Int, photos: Int, recordings: Int, links: Int) {
        self.note = "\(notes) text"
        self.photo = "\(photos) photos"
        self.link = "\(links) images"
        self.recording = "\(recordings) recordings"
        self.total = notes + photos + recordings + links
        
        noteInt = notes
        photoInt = photos
        recordingInt = recordings
        linkInt =  links
    }
    
    var noteInt: Int
    var photoInt: Int
    var linkInt: Int
    var recordingInt: Int
}
