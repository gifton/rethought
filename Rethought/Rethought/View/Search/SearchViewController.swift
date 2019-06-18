
import Foundation
import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Device.colors.offWhite
        setView()
    }
    
    let tv: UITableView = {
        let tv = UITableView()
        
        return tv
    }()
    
    func setView() {
        view.addSubview(tv)
        tv.frame = view.frame
        tv.delegate = self
        tv.dataSource = self
        
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
