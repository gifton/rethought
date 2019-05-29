
import Foundation
import UIKit

class MSGBoardComponent: UIView {
    var componentType: MSGContext.board.viewType = .welcomeCard
    var cardSize: CGSize {
        return frame.size
    }
}
