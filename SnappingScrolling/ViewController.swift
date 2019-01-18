//
//  ViewController.swift
//  SnappingScrolling
//
//  Created by Ahmed Khalaf on 1/10/19.
//  Copyright © 2019 Ahmed Khalaf. All rights reserved.
//

import UIKit

fileprivate let cellSize = CGSize(width: 80, height: 50)
fileprivate var insetSpacing: CGFloat = 0

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var targetIndexLabel: UILabel!
    
    let data: [Int] = Array(0..<300)
    let colors: [UIColor] = Array(repeating: [UIColor.red, .green, .blue], count: 100).flatMap({ $0 })

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        insetSpacing = collectionView.bounds.width / 2 - cellSize.width / 2
        collectionView.performBatchUpdates(nil, completion: nil)
        super.viewDidLayoutSubviews()
    }

}

class Cell: UICollectionViewCell {
    @IBOutlet private weak var label: UILabel!
    
    var index = 0 {
        didSet {
            guard label != nil else { return }
            
            label.text = "\(index)"
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.index = data[indexPath.row]
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        print("targetContentOffset.pointee.x: \(targetContentOffset.pointee.x)")
        
        var targetIndex = (targetContentOffset.pointee.x + cellSize.width / 2) / cellSize.width
        print("targetIndex: \(targetIndex)")
        print("velocity.x: \(velocity.x)")
        targetIndex = velocity.x > 0 ? ceil(targetIndex) : floor(targetIndex)
        targetIndex = targetIndex.clamped(minValue: 0, maxValue: CGFloat(data.count - 1))
        targetContentOffset.pointee.x = targetIndex * cellSize.width
        
        print(targetIndex)
        targetIndexLabel.text = "\(Int(targetIndex))"
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        targetIndexLabel.text = ""
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: insetSpacing, bottom: 0, right: insetSpacing)
    }
}

extension CGFloat {
    func clamped(minValue: CGFloat, maxValue: CGFloat) -> CGFloat {
        return Swift.min(maxValue, Swift.max(minValue, self))
    }
}

