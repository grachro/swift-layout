//
//  ScrollViewAndWordWrappingLabelController.swift
//  swift-layout
//
//  Created by grachro on 2014/10/24.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class ScrollViewAndWordWrappingLabelController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollView = UIScrollView()
        Layout.addSubView(scrollView, superview: self.view)
            .top(0).fromBottom(self.topLayoutGuide)
            .leftIsSameSuperview()
            .rightIsSameSuperview()
            .bottomIsSameSuperview()
            .backgroundColor(UIColor.grayColor())
  

        let label1 = Layout.createWordWrappingLabel("秋の田の かりほの庵の 苫をあらみ 我が衣手は 露にぬれつつ")
        Layout.addSubView(label1, superview: scrollView)
            .topIsSameSuperview()
            .leftIsSameSuperview()
            .widthIsSame(self.view, constraintOwner: self.view)//<< important
            .font(UIFont.systemFontOfSize(60))
            .backgroundColor(UIColor.greenColor())

        let label2 = Layout.createWordWrappingLabel("春過ぎて 夏来にけらし 白妙の 衣ほすてふ 天の香具山")
        Layout.addSubView(label2, superview: scrollView)
            .top(20).fromBottom(label1)
            .leftIsSameSuperview()
            .widthIsSame(self.view, constraintOwner: self.view)//<< important
            .font(UIFont.systemFontOfSize(60))
            .backgroundColor(UIColor.yellowColor())
            .bottomIsSameSuperview() //<< important
        
        //戻るボタン
        addReturnBtn()
    }

    private func addReturnBtn() {
        let btn = Layout.createSystemTypeBtn("return")
        Layout.addSubView(btn, superview: self.view)
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

