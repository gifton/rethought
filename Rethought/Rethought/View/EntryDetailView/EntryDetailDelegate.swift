
import Foundation

protocol EntryDetailDelegate {
    func updateEntry(withEntry: EntryBuilder)
    func returnHome()
    func deleteEntry()
}
