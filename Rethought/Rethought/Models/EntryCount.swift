
// Thought entry amounts
struct EntryCount {
    var note:      String
    var photo:     String
    var link:      String
    var recording: String
    
    init(notes: Int, photos: Int, recordings: Int, links: Int) {
        self.note = "\(notes) notes"
        self.photo = "\(photos) photos"
        self.link = "\(links) images"
        self.recording = "\(recordings) recordings"
        self.total = notes + photos + recordings + links
        
        noteInt = notes
        photoInt = photos
        recordingInt = recordings
        linkInt =  links
    }
    
    static var zero: EntryCount {
        return EntryCount(notes: 0, photos: 0, recordings: 0, links: 0)
    }
    
    // display counts as an int instead of string
    var noteInt: Int
    var photoInt: Int
    var linkInt: Int
    var recordingInt: Int
    var total:     Int
}
