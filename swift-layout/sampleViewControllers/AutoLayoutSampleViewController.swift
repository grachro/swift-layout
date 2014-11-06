//
//  AutoLayoutSampleController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/08.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class AutoLayoutSampleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let centerView = centerViews()
        middleViews(centerView)
        cornerViews(centerView)
        
        //戻るボタン
        addReturnBtn()
    }
    
    private func centerViews() -> UIView {
        
        let color = UIColor.lightGrayColor()
        
        
        
        let 中央 = UILabel()
        中央.text = "中央"
        Layout.addSubView(中央, superview: self.view)
            .horizontalCenterInSuperview()
            .verticalCenterInSuperview()
            .backgroundColor(color)
        
        
        let 右隣 = UILabel()
        右隣.text = "右隣"
        Layout.addSubView(右隣, superview: self.view)
            .left(20).fromRight(中央)
            .verticalCenterIsSame(中央)
            .backgroundColor(color)

        
        let 左隣 = UILabel()
        左隣.text = "左隣"
        Layout.addSubView(左隣, superview: self.view)
            .right(20).fromLeft(中央)
            .verticalCenterIsSame(中央)
            .backgroundColor(color)

        
        let 上隣 = UILabel()
        上隣.text = "上隣"
        Layout.addSubView(上隣, superview: self.view)
            .bottom(20).fromTop(中央)
            .horizontalCenterIsSame(中央)
            .backgroundColor(color)

        
        let 下隣 = UILabel()
        下隣.text = "下隣"
        Layout.addSubView(下隣, superview: self.view)
            .top(20).fromBottom(中央)
            .horizontalCenterIsSame(中央)
            .backgroundColor(color)

        
        return 中央
    }
    
    private func middleViews(centerView:UIView) {
        
        let color = UIColor.yellowColor()
        
        let d:CGFloat = 40
        
        let 左上40 = UILabel()
        左上40.text = "40"
        Layout.addSubView(左上40, superview: self.view)
            .top(d).fromSuperviewTop()
            .left(d).fromSuperviewLeft()
            .backgroundColor(color)

        
        let 右上40 = UILabel()
        右上40.text = "40"
        Layout.addSubView(右上40, superview: self.view)
            .top(d).fromSuperviewTop()
            .right(d).fromSuperviewRight()
            .backgroundColor(color)

        
        let 左下40 = UILabel()
        左下40.text = "40"
        Layout.addSubView(左下40, superview: self.view)
            .bottom(d).fromSuperviewBottom()
            .left(d).fromSuperviewLeft()
            .backgroundColor(color)

        
        let 右下40 = UILabel()
        右下40.text = "40"
        Layout.addSubView(右下40, superview: self.view)
            .bottom(d).fromSuperviewBottom()
            .right(d).fromSuperviewRight()
            .backgroundColor(color)


        
        //more
        let 左40 = UILabel()
        左40.text = "40"
        Layout.addSubView(左40, superview: self.view)
            .verticalCenterIsSame(centerView)
            .leftIsSame(左上40)
            .backgroundColor(color)
        
        
        let 右40 = UILabel()
        右40.text = "40"
        Layout.addSubView(右40, superview: self.view)
            .verticalCenterIsSame(centerView)
            .rightIsSame(右上40)
            .backgroundColor(color)
        
        
        let 上40 = UILabel()
        上40.text = "40"
        Layout.addSubView(上40, superview: self.view)
            .topIsSame(左上40)
            .horizontalCenterIsSame(centerView)
            .backgroundColor(color)
        
        
        let 下40 = UILabel()
        下40.text = "40"
        Layout.addSubView(下40, superview: self.view)
            .bottomIsSame(右下40)
            .horizontalCenterIsSame(centerView)
            .backgroundColor(color)
    }
    
    private func cornerViews(centerView:UIView) {
        
        let color = UIColor.greenColor()

        
        let lbl左上 = UILabel()
        lbl左上.text = "左上"
        Layout.addSubView(lbl左上, superview: self.view)
            .topIsSameSuperview()
            .leftIsSameSuperview()
            .backgroundColor(color)
        
        
        let lbl右上 = UILabel()
        lbl右上.text = "右上"
        Layout.addSubView(lbl右上, superview: self.view)
            .topIsSameSuperview()
            .rightIsSameSuperview()
            .backgroundColor(color)
        
        
        let lbl左下 = UILabel()
        lbl左下.text = "左下"
        Layout.addSubView(lbl左下, superview: self.view)
            .bottomIsSameSuperview()
            .leftIsSameSuperview()
            .backgroundColor(color)
        
        
        let lbl右下 = UILabel()
        lbl右下.text = "右下"
        Layout.addSubView(lbl右下, superview: self.view)
            .bottomIsSameSuperview()
            .rightIsSameSuperview()
            .backgroundColor(color)
        
        
        
        
        //more
        let lbl左 = UILabel()
        lbl左.text = "左"
        Layout.addSubView(lbl左, superview: self.view)
            .verticalCenterIsSame(centerView)
            .leftIsSame(lbl左上)
            .backgroundColor(color)
        
        
        let lbl右 = UILabel()
        lbl右.text = "右"
        Layout.addSubView(lbl右, superview: self.view)
            .verticalCenterIsSame(centerView)
            .rightIsSame(lbl右上)
            .backgroundColor(color)
        
        
        let lbl上 = UILabel()
        lbl上.text = "上"
        Layout.addSubView(lbl上, superview: self.view)
            .topIsSame(lbl左上)
            .horizontalCenterIsSame(centerView)
            .backgroundColor(color)
        
        
        let lbl下 = UILabel()
        lbl下.text = "下"
        Layout.addSubView(lbl下, superview: self.view)
            .bottomIsSame(lbl右下)
            .horizontalCenterIsSame(centerView)
            .backgroundColor(color)
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
