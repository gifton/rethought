
import Foundation
import UIKit

class EntryScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white.withAlphaComponent(0.15)
        contentSize = CGSize(width: 525, height: 80)
        showsHorizontalScrollIndicator = false
        setView()
    }
    
    let allButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "cloud_btn")!
        btn.setTitle(" All", for: .normal)
        btn.frame.size = CGSize(width: 50, height: 25)
        btn.setImage(img, for: .normal)
        return btn
    }()
    let linkButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Links", for: .normal)
        btn.frame.size = CGSize(width: 40, height: 25)
        let img = UIImage(named: "link_btn")!
        btn.setImage(img, for: .normal)
        return btn
    }()
    let noteButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "note_btn")!
        btn.setTitle(" Notes", for: .normal)
        btn.frame.size = CGSize(width: 70, height: 25)
        btn.setImage(img, for: .normal)
        return btn
    }()
    let recordingButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "recording_btn")!
        btn.setTitle(" Recordings", for: .normal)
        btn.frame.size = CGSize(width: 100, height: 25)
        btn.setImage(img, for: .normal)
        return btn
    }()
    let photoButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "photo_btn")!
        btn.frame.size = CGSize(width: 80, height: 25)
        btn.setTitle(" Photos", for: .normal)
        btn.setImage(img, for: .normal)
        return btn
    }()
    
    private func setView() {
        let btns = [allButton, linkButton, noteButton, recordingButton, photoButton]
        for btn in btns {
            btn.frame.size.height = 25
        }
        let stack = UIStackView(arrangedSubviews: btns,
                                axis: .horizontal,
                                spacing: 25, alignment: .fill, distribution: .fillProportionally)
        stack.frame = CGRect(x: 15, y: 45, width: contentSize.width - 25, height: 25)
        addSubview(stack)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
