
import Foundation
import UIKit

class EntryDetalScrollView: UIScrollView {
    init(withBuilder builder: EntryBuilder) {
        self.builder = builder
        super.init(frame: Device.size.frame)
    }
    
    var builder: EntryBuilder {
        didSet {
            print("builder initiated")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
