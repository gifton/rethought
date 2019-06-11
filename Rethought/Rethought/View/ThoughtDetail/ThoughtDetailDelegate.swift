
import Foundation

protocol ThoughtDetailDelegate {
    func requestClose()
    func delete(entry: Entry)
    func deleteThought()
    func search(for payload: String)
    func endSearch()
    func updateIcon(to: String)
    var thought: ThoughtPreview { get }
    
}
