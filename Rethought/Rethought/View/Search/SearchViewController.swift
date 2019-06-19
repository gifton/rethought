
import Foundation
import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Device.colors.offWhite
        setView()
    }
    
    public var model: SearchViewModel?
    
    let tv: UITableView = {
        let tv = UITableView()
        
        return tv
    }()
    
    func setView() {
        view.addSubview(tv)
        
        tv.frame = Device.size.frame
        tv.delegate = self
        tv.dataSource = self
        tv.registerHeaderFooter(cellWithClass: SearchHeadView.self)
        tv.register(cellWithClass: SearchThoughtCell.self)
        tv.separatorStyle = .none
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return SearchHeadView()
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else { return UITableViewCell() }
        return model.cell(forIndex: indexPath, tableView: tableView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected: \(indexPath.row)")
    }
}
