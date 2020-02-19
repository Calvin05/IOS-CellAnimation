//
//  ViewController.swift
//  Animation4
//
//  Created by Cường Nguyễn on 2019-02-12.
//  Copyright © 2019 Cường Nguyễn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numViewPerRow = 15
    
    var cells = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        for j in 0...30 {
            for i in 0...numViewPerRow {
                let viewCell = UIView()
                viewCell.backgroundColor = randomColor()
                viewCell.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                viewCell.layer.borderWidth = 0.5
                viewCell.layer.borderColor = UIColor.black.cgColor
                view.addSubview(viewCell)
                
                let key = "\(i)|\(j)"
                cells[key] = viewCell
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    var selectedCell: UIView?
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        print(location)
        
        let width = view.frame.width / CGFloat(numViewPerRow)

        let i = Int(location.x / width)
        let j = Int(location.y / width)
        print(i, j)
        
        let key = "\(i)|\(j)"
        
        guard let cellView = cells[key] else {return}
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView
        view.bringSubviewToFront(cellView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeRotation(.pi, 0, 0, 1)
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
            
            //cellView?.backgroundColor = .black
        }, completion: nil)
//        UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            cellView.layer.transform = CATransform3DMakeRotation(.pi, 0, 0, 1)
//            //cellView?.backgroundColor = .black
//        }, completion: nil)
        
//        if gesture.state == .ended {
//            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
//                cellView.layer.transform = CATransform3DIdentity
//            }, completion: { _ in
//                
//            })
//        }
//        var loopCount = 0
//        for subview in view.subviews {
//            if subview.frame.contains(location) {
//                subview.backgroundColor = .black
//                //print(loopCount)
//            }
//            loopCount += 1
//        }
    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}


