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
            let lTop = Layout.registUILabel(superview: self.view)
            .top(30).fromSuperviewTop()
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.redColor())
            .text("Top")
            .roundRectTop(20)
        
        let lRight = Layout.registUILabel(superview: self.view)
            .top(10).fromBottom(lTop.view)
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.cyanColor())
            .text("Right")
            .roundRectRight(20)
  
        let lLeft = Layout.registUILabel(superview: self.view)
            .top(30).fromSuperviewTop()
            .left(10).fromRight(lTop.view)
            .width(100)
            .height(100)
            .backgroundColor(UIColor.yellowColor())
            .text("Left")
            .roundRectLeft(20)
        
        let lBottom = Layout.registUILabel(superview: self.view)
            .top(10).fromBottom(lLeft.view)
            .left(10).fromRight(lRight.view)
            .width(100)
            .height(100)
            .backgroundColor(UIColor.greenColor())
            .text("Bottom")
            .roundRectBottom(20)
        
        let layout5 = Layout.regist(Layout.createCharWrappingLabel("TopLeft\nBottomRight"), superview: self.view)
            .top(10).fromBottom(lRight.view)
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.grayColor())
            .roundRect(byRoundingCorners: (UIRectCorner.TopLeft | UIRectCorner.BottomRight), cornerRadii: 20)
        
        let layout6 = Layout.regist(Layout.createCharWrappingLabel("all"), superview: self.view)
            .top(10).fromBottom(lRight.view)
            .left(10).fromRight(lTop.view)
            .width(100)
            .height(100)
            .backgroundColor(UIColor.blueColor())
            .roundRect(20)
        
        //戻るボタン
        addReturnBtn()
    }
    
    private func addReturnBtn() {
        let btn = Layout.createSystemTypeBtn("return")
        Layout.regist(btn, superview: self.view)
            .bottomIsSameSuperview()
            .rightIsSameSuperview()
        
        TouchBlocks.append(btn){
            self.dismissViewControllerAnimated(true, completion:nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
