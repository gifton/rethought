
import Foundation
import UIKit
import CoreLocation

class ThoughtDetailController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: variables
    lazy var headView = ThoughtDetailSearchBar(startFrame: CGRect(x: 0, y: -100, width: Device.size.width, height: 100), endFrame: CGRect(x: 0, y: 0, width: Device.size.width, height: 100), preview: thought)
    var table = ThoughtDetailTable(frame: CGRect(origin: .zero, size: CGSize(width: Device.size.width, height: Device.size.height - 115)))
    var msgCenter: MSGCenter!
    
    // MARK: objects
    let animationScrollLength: CGFloat = 100.0
    var progress: CGFloat = 0.0 {
        didSet { animator.updateAnimation(toProgress: progress) }
    }
    
    // MARK: public objects
    public var model: ThoughtDetailViewModel! {
        didSet { setView() }
    }
    
    public var animator = ViewAnimator()
    
    private func setView() {
        
        // set table delegates and datasources
        table.tv.delegate = self
        table.tv.dataSource = self
        table.tv.register(cellWithClass: ThoughtDetailTableHead.self)
        table.tv.register(cellWithClass: NoteEntryCell.self)
        table.tv.register(cellWithClass: LinkEntryCell.self)
        table.tv.register(cellWithClass: PhotoEntryCell.self)
        
        headView.delegate = self
        animator.register(animatableView: headView)
        
        createMSGCenter()
        view.addSubview(table)
        view.addSubview(msgCenter)
        view.addSubview(headView)
        
        addCloseButton()
    }
    
    private func createMSGCenter() {
        // set msgCenter
        msgCenter = MSGCenter(frame: CGRect(x: 0, y: view.frame.height - 115, width: view.frame.width, height: 115), connector: self, isFull: false)
        msgCenter.delegate = self
        
        // add shadow to msg center
        msgCenter.hasShadow = true
    }
    
    private func addCloseButton() {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "collapse"), for: .normal)
        btn.frame = CGRect(x: view.frame.width - 60, y: view.frame.height - 105, width: 45, height: 45)
        btn.addTapGestureRecognizer {
            self.requestClose()
        }
        view.addSubview(btn)
    }
}

extension ThoughtDetailController: ThoughtDetailDelegate {
    var thought: ThoughtPreview {
        return model.thought.preview
    }
    
    func requestClose() {
        navigationController?.popViewController(animated: true)
    }
    
    func delete(entry: Entry) { }
    
    func delete(thought: Thought) { }
    
    func search(for payload: String) {
        print("begining model search from controller")
        model.search(payload) {
            self.table.tv.reloadData()
        }
        
    }
    
    func updateIcon(to: String) { }
    
    func endSearch() {
        resignFirstResponder()
        model.doneSearching { self.table.tv.reloadData() }
    }
}


extension ThoughtDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  model.cellFor(index: indexPath, tableView: tableView) else {
            print("unable to register cell from controller model method call")
            return UITableViewCell()
        }
        
        // register cell as animateable only if it is
        if let conformedCell = cell as? Animatable {
            animator.register(animatableView: conformedCell)
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headView.sb.resignFirstResponder()
        msgCenter.entryDidRequestCancel()
        updateMSGSize(size: .regular)
        _ = msgCenter.removeEntryView()
        if let scroll = scrollView as? UITableView {
            if scroll.numberOfRows(inSection: 0) >= 4 {
                let offset = scroll.contentOffset.y
                let normalizedOffset = max(0.0, min(1.0, offset/animationScrollLength))
                self.progress = normalizedOffset
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model.heightFor(row: indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.tableCount + 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = model.tapped(row: indexPath.row)
        let controller = EntryDetailController(withModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            model.delete(entryAtIndex: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension ThoughtDetailController: MSGConnector, MSGCenterDelegate {
    
    func didTapEntry(ofType type: MSGContext.size, completion: ()) {
        if type.rawValue != 115 {
            updateMSGSize(size: type)
        } else {
            updateMSGSize(size: .regular)
        }
        
    }
    
    private func updateMSGSize(size: MSGContext.size) {
        UIView.animate(withDuration: 0.3) {
            self.msgCenter.frame.size.height = size.rawValue
            self.msgCenter.frame.origin.y = self.view.frame.height - size.rawValue
        }
    }
    
    func didSendMessage() { }
    
    func save(withTitle title: String, withIcon: ThoughtIcon) { }
    
    func insert<T>(entry: T) where T : EntryBuilder {
        model.buildEntry(payload: entry, withLocation: CLLocation(), completion: {
            self.table.tv.reloadData()
        })
    }
    
    func isDoneEditing() { }
    
    func updateIcon(newIcon: ThoughtIcon) { }
    
    func entryWillShow(ofType type: MSGContext.size) {
        
    }
    
    
}
