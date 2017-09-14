//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Devin Reich on 9/13/17.
//  Copyright © 2017 Devin Reich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numViewPerRow = 15
    var cells = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        for row in 0...30 {
            for column in 0...numViewPerRow {
                let cellView = UIView()
                cellView.layer.borderColor = UIColor.black.cgColor
                cellView.layer.borderWidth = 0.5
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(column) * width, y: CGFloat(row) * width, width: width, height: width)
                view.addSubview(cellView)
                let key = "\(row)|\(column)"
                cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    var selectedCell: UIView?
    
    func handlePan(gesture:UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        let column = Int(location.x / width)
        let row = Int(location.y / width)
        
        let key = "\(row)|\(column)"
        
        guard let cellView = cells[key] else { return }
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        view.bringSubview(toFront: cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:{
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cellView.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}

