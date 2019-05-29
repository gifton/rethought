
//thought icon only allows 1 char at a time
final class ThoughtIcon {
    public var icon: String
    init(_ icon: String = "🚫") {
        //if theres multiple characters default to "🚫"
        if icon.count != 1 {
            self.icon = "🚫"
        } else {
            self.icon = icon
        }
    }
}
