import UIKit
import Foundation
import AVKit


struct RecordingBuilder: EntryBuilder {
    var type: EntryType = .recording
    
    var userDetail: String
    var recording: AudioFileID
    var entry: Entry?
    
    init(userDetail: String, recording: AudioFileID, forEntry entry: Entry?) {
        self.userDetail = userDetail
        self.recording = recording
        self.entry = entry
    }
}
