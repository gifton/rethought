
import Foundation
import UIKit



class EntryDetailController: UIViewController {
    var entry: Entry { return model.entry }
    var scrollView: EntryDetailScrollView!
    
    init(withModel model: EntryDetailViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        scrollView = EntryDetailScrollView(withBuilder: model.builder)
        scrollView.entryDelegate = self
        view = scrollView
    }
    
    var model: EntryDetailViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntryDetailController: EntryDetailDelegate {
    func updateEntry(withEntry: EntryBuilder) { }
    func returnHome() {        
        navigationController?.popViewController(animated: true)
    }
}
