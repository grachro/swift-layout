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

        self.view.backgroundColor = UIColor.white
            let lTop = Layout.addUILabel(superview: self.view)
            .top(30).fromSuperviewTop()
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.red)
            .text("Top")
            .roundRectTop(20)
        
        let lRight = Layout.addUILabel(superview: self.view)
            .top(10).fromBottom(lTop.view)
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.cyan)
            .text("Right")
            .roundRectRight(20)
  
        let lLeft = Layout.addUILabel(superview: self.view)
            .top(30).fromSuperviewTop()
            .left(10).fromRight(lTop.view)
            .width(100)
            .height(100)
            .backgroundColor(UIColor.yellow)
            .text("Left")
            .roundRectLeft(20)
        
        _ = Layout.addUILabel(superview: self.view)
            .top(10).fromBottom(lLeft.view)
            .left(10).fromRight(lRight.view)
            .width(100)
            .height(100)
            .backgroundColor(UIColor.green)
            .text("Bottom")
            .roundRectBottom(20)
        
        _ = Layout.addSubView(Layout.createCharWrappingLabel("TopLeft\nBottomRight"), superview: self.view)
            .top(10).fromBottom(lRight.view)
            .left(50).fromSuperviewLeft()
            .width(100)
            .height(100)
            .backgroundColor(UIColor.gray)
            .roundRect(byRoundingCorners: ([UIRectCorner.topLeft, UIRectCorner.bottomRight]), cornerRadii: 20)
        
        _ = Layout.addSubView(Layout.createCharWrappingLabel("all"), superview: self.view)
            .top(10).fromBottom(lRight.view)
            .left(10).fromRight(lTop.view)
            .width(100)
            .height(100)
            .backgroundColor(UIColor.blue)
            .roundRect(20)
        
        //戻るボタン
        addReturnBtn()
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
        // Dispose of any resources that can be recreated.
    }
    


}
