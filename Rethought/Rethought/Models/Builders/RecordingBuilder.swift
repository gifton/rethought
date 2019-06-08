import UIKit
import Foundation
import AVKit


struct RecordingBuilder: EntryBuilder {
    var type: EntryType = .recording
    var thoughtIcon: ThoughtIcon = ThoughtIcon("💭")
    var userDetail: String
    var recording: AudioFileID
    var entry: Entry?
    // TODO: make this an recording builder
    static var zero: EntryBuilder {
        return LinkBuilder(link: "", rawIconUrl: "", detail: "", title: "", forEntry: nil)
    }
    
    init(userDetail: String, recording: AudioFileID, forEntry entry: Entry?) {
        self.userDetail = userDetail
        self.recording = recording
        self.entry = entry
    }
}
