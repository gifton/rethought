// Basic building block of Rethought:
//User inputs a note that they want to remember (eg: where they hid a christmas present)

struct Tracker: Recore {
    //recore
    var title: String
    var detail: String
    var dateStamp: String
    var list: String
    var favorite: Bool
    var isEditable: Bool
    //unique to Thought
    var location: String
    var image: UIIMage
}
