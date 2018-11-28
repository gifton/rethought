//
//  Dashboardf.swift
//  Rethought
//
//  Created by Dev on 11/17/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MasterController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view = MasterView(frame: .zero)
        navigationController?.isNavigationBarHidden = true
        navigationController?.title = "Dashboard"
    }
    
}

extension MasterView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.titleLabel.text = "\(indexPath.row)"
        return CGSize(width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT - 200)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: MasterCell.identifier, for: indexPath) as! MasterCell
//        switch indexPath.row {
//        case 0:
//            cell.backgroundColor = .mainRed
//        case 1:
//            cell.backgroundColor = .blueSmoke
//        case 2:
//            cell.backgroundColor = .brightGreen
//        default:
//            cell.backgroundColor = .black
//        }
        return cell
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let pageWidth:Float = Float(self.bounds.width)
        let minSpace:Float = 2.5
        var cellToSwipe:Double = Double(Float((scrollView.contentOffset.x))/Float((pageWidth+minSpace))) + Double(0.5)
        if cellToSwipe < 0 {
            cellToSwipe = 0
        } else if cellToSwipe >= Double(3) {
            cellToSwipe = Double(3) - Double(1)
        }
        let indexPath:IndexPath = IndexPath(row: Int(cellToSwipe), section:0)
        self.MasterCollection.scrollToItem(at:indexPath, at: UICollectionView.ScrollPosition.left, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch MasterCollection.indexPathsForVisibleItems {
        case [[0, 0]]:
            titleLabel.text = "Profile"
        case [[0, 1]]:
            titleLabel.text = "Dashboard"
        case [[0, 2]]:
            titleLabel.text = "Thoughts"
        default:
            titleLabel.text = titleLabel.text
        }
    }
}
