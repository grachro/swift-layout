//
//  RoundedRectViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/28.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class RoundedRectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
            let layout1 = Layout.registUILabel(superview: self.view)
            .top(30).fromSuperviewTop()
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.redColor())
            .text("Top")
            .roundRectTop(20)
        
        let layout2 = Layout.registUILabel(superview: self.view)
            .top(10).fromBottom(layout1.view)
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.cyanColor())
            .text("Right")
            .roundRectRight(20)
  
        let layout3 = Layout.registUILabel(superview: self.view)
            .top(30).fromSuperviewTop()
            .left(10).fromRight(layout1.view)
            .width(100)
            .height(100)
            .backgroundColor(UIColor.yellowColor())
            .text("Left")
            .roundRectLeft(20)
        
        let layout4 = Layout.registUILabel(superview: self.view)
            .top(10).fromBottom(layout3.view)
            .left(10).fromRight(layout2.view)
            .width(100)
            .height(100)
            .backgroundColor(UIColor.greenColor())
            .text("Bottom")
            .roundRectBottom(20)
        
        let layout5 = Layout.regist(Layout.createCharWrappingLabel("TopLeft\nBottomRight"), superview: self.view)
            .top(10).fromBottom(layout2.view)
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.grayColor())
            .roundRect(byRoundingCorners: (UIRectCorner.TopLeft | UIRectCorner.BottomRight), cornerRadii: 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
