//
//  VerticalEvenSpaceViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/07.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class VerticalEvenSpaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        threeItems()
        fourItems()
        
        
        //戻るボタン
        addReturnBtn()
    }
    
    
    func threeItems() {
        let l1 = UILabel()
        l1.text = "l1"
        l1.backgroundColor = UIColor.red
        Layout.addSubView(l1, superview: self.view)
            .left(50).fromSuperviewLeft()
            .width(30)
        
        let l2 = UILabel()
        l2.text = "l2"
        l2.backgroundColor = UIColor.green
        Layout.addSubView(l2, superview: self.view)
            .horizontalCenterIsSame(l1)
            .widthIsSame(l1)
        
        
        let l3 = UILabel()
        l3.text = "l3"
        l3.backgroundColor = UIColor.blue
        Layout.addSubView(l3, superview: self.view)
            .horizontalCenterIsSame(l1)
            .widthIsSame(l1)
        
        Layout.verticalEvenSpaceInCotainer(superview: self.view, views: [l1,l2,l3], coverSpace: true)
    }
    
    func fourItems() {
        let l1 = UILabel()
        l1.text = "l1"
        l1.backgroundColor = UIColor.red
        Layout.addSubView(l1, superview: self.view)
            .right(50).fromSuperviewRight()
            .width(30)
        
        let l2 = UILabel()
        l2.text = "l2"
        l2.backgroundColor = UIColor.green
        Layout.addSubView(l2, superview: self.view)
            .horizontalCenterIsSame(l1)
            .widthIsSame(l1)
        
        
        let l3 = UILabel()
        l3.text = "l3"
        l3.backgroundColor = UIColor.blue
        Layout.addSubView(l3, superview: self.view)
            .horizontalCenterIsSame(l1)
            .widthIsSame(l1)
        
        
        let l4 = UILabel()
        l4.text = "l4"
        l4.backgroundColor = UIColor.yellow
        Layout.addSubView(l4, superview: self.view)
            .horizontalCenterIsSame(l1)
            .widthIsSame(l1)
        
        Layout.verticalEvenSpaceInCotainer(superview: self.view, views: [l1,l2,l3,l4], coverSpace: false)
    }
    
    fileprivate func addReturnBtn() {
        
        let btn = Layout.createSystemTypeBtn("return")
        Layout.addSubView(btn, superview: self.view)
            .bottomIsSameSuperview()
            .rightIsSameSuperview()
        TouchBlocks.append(btn){
            self.dismiss(animated: true, completion:nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
