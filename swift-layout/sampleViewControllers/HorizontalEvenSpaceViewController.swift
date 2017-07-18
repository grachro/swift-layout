//
//  HorizontalEvenSpaceViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/07.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class HorizontalEvenSpaceViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        coverSpace()
        nonCoverSpace()
        
        //戻るボタン
        addReturnBtn()
    }
    
    fileprivate func coverSpace() {
        let l1 = UILabel()
        l1.text = "l1"
        l1.backgroundColor = UIColor.red
        Layout.addSubView(l1, superview: self.view)
            .top(30).fromSuperviewTop()
            .width(30)
            .height(50)
        
        let l2 = UILabel()
        l2.text = "l2"
        l2.backgroundColor = UIColor.green
        Layout.addSubView(l2, superview: self.view)
            .verticalCenterIsSame(l1)
            .widthIsSame(l1)
            .height(60)
        
        
        let l3 = UILabel()
        l3.text = "l3"
        l3.backgroundColor = UIColor.blue
        Layout.addSubView(l3, superview: self.view)
            .verticalCenterIsSame(l1)
            .widthIsSame(l1)
            .height(60)
        
        Layout.horizontalEvenSpaceInCotainer(superview: self.view, views: [l1,l2,l3], coverSpace: true)
    }
    
    fileprivate func nonCoverSpace() {
        let l1 = UILabel()
        l1.text = "l1"
        l1.backgroundColor = UIColor.red
        Layout.addSubView(l1, superview: self.view)
            .bottom(30).fromSuperviewBottom()
            .width(30)
            .height(50)
        
        let l2 = UILabel()
        l2.text = "l2"
        l2.backgroundColor = UIColor.green
        Layout.addSubView(l2, superview: self.view)
            .verticalCenterIsSame(l1)
            .widthIsSame(l1)
            .height(60)
        
        
        let l3 = UILabel()
        l3.text = "l3"
        l3.backgroundColor = UIColor.blue
        Layout.addSubView(l3, superview: self.view)
            .verticalCenterIsSame(l1)
            .widthIsSame(l1)
            .height(60)
        
        Layout.horizontalEvenSpaceInCotainer(superview: self.view, views: [l1,l2,l3], coverSpace: false)
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
