
import Foundation

protocol ThoughtDetailDelegate {
    func requestClose()
    func delete(entry: Entry)
    func delete(thought: Thought)
    func search(for payload: String)
    func endSearch()
    func updateIcon(to: String)
    var thought: ThoughtPreview { get }
    
}
