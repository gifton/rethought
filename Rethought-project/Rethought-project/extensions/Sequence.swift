import Foundation

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

//sequencing methods for thoughts
extension Sequence where Self.Element: Thought {
    
    //convert all thoughts in list to preview
    func toPreview() -> [ThoughtPreview] {
        var thoughtPreviews = [ThoughtPreview]()
        self.forEach { (thought) in
            let t = ThoughtPreview(thought: thought as Thought)
            thoughtPreviews.append(t)
        }
        return thoughtPreviews
    }
    
    //get all entries as [Entry]
    func getEntries() -> [Entry] {
        var ents = [Entry]()
        self.forEach { (thought) in
            let thought = thought as Thought
            ents += thought.entries
        }
        
        return ents
    }
}
