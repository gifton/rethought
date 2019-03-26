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

extension Sequence where Iterator.Element: AnyObject {
    func containsObjectIdentical(to object: AnyObject) -> Bool {
        return contains { $0 === object }
    }
}

//return list of textEntry to [TextEntryPreview]
extension Sequence where Iterator.Element: TextEntry {
    func toPreview() -> [TextEntryPreview] {
        var output = [TextEntryPreview]()
        forEach { (input) in
            output.append(TextEntryPreview(input as TextEntry))
        }
        return output
    }
}

//return list of textEntry to [TextEntryPreview]
extension Sequence where Iterator.Element: MediaEntry {
    func toPreview() -> [MediaEntryPreview] {
        var output = [MediaEntryPreview]()
        forEach { (input) in
            output.append(MediaEntryPreview(input as MediaEntry))
        }
        return output
    }
}

//return list of textEntry to [TextEntryPreview]
extension Sequence where Iterator.Element: LinkEntry {
    func toPreview() -> [LinkEntryPreview] {
        var output = [LinkEntryPreview]()
        forEach { (input) in
            output.append(LinkEntryPreview(input as LinkEntry))
        }
        return output
    }
}
