//
//  Sample2ViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/07.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class Sample2ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        var l1 = UILabel()
        l1.text = "l1"
        l1.backgroundColor = UIColor.redColor()
        Layout.regist(l1, container: self.view)
            .verticalCenterInContainer()
            .width(30)
            .height(50)
        
        var l2 = UILabel()
        l2.text = "l2"
        l2.backgroundColor = UIColor.greenColor()
        Layout.regist(l2, container: self.view)
            .verticalCenterIsSame(l1)
            .widthIsSame(l1)
            .height(60)

        
        var l3 = UILabel()
        l3.text = "l3"
        l3.backgroundColor = UIColor.blueColor()
        Layout.regist(l3, container: self.view)
            .verticalCenterIsSame(l1)
            .widthIsSame(l1)
            .height(60)
        
        Layout.horizontalEvenSpaceInCotainer(container: self.view, views: [l1,l2,l3], coverSpace: true)
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
