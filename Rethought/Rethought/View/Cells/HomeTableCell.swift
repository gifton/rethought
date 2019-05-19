
import Foundation
import UIKit

class HomeTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Device.colors.offWhite
        setCell()
    }
    
    let cell = UIView()
    let moreBtn = UIButton()
    
    func setCell() {
        addSubview(cell)
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .white
        cell.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingBottom: 5, paddingTrailing: 10)
        
        setViews()
    }
    
    private func setViews() {
        cell.addSubview(moreBtn)
        moreBtn.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        moreBtn.frame = CGRect(x: frame.width + 25, y: 30, width: 10, height: 30)
    }
    
    static var identifier: String {
        return "HomeTableCellV1"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
