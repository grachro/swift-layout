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

        self.view.backgroundColor = UIColor(red:0.78, green:0.89, blue:1.00, alpha:1.0)
        
        
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
        Layout.regist(中央, container: self.view)
            .horizontalCenterInContainer()
            .verticalCenterInContainer()
            .backgroundColor(color)
        
        
        let 右隣 = UILabel()
        右隣.text = "右隣"
        Layout.regist(右隣, container: self.view)
            .left(20).fromRight(中央)
            .verticalCenterIsSame(中央)
            .backgroundColor(color)

        
        let 左隣 = UILabel()
        左隣.text = "左隣"
        Layout.regist(左隣, container: self.view)
            .right(20).fromLeft(中央)
            .verticalCenterIsSame(中央)
            .backgroundColor(color)

        
        let 上隣 = UILabel()
        上隣.text = "上隣"
        Layout.regist(上隣, container: self.view)
            .bottom(20).fromTop(中央)
            .horizontalCenterIsSame(中央)
            .backgroundColor(color)

        
        let 下隣 = UILabel()
        下隣.text = "下隣"
        Layout.regist(下隣, container: self.view)
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
        Layout.regist(左上40, container: self.view)
            .top(d).fromContainerTop()
            .left(d).fromContainerLeft()
            .backgroundColor(color)

        
        let 右上40 = UILabel()
        右上40.text = "40"
        Layout.regist(右上40, container: self.view)
            .top(d).fromContainerTop()
            .right(d).fromContainerRight()
            .backgroundColor(color)

        
        let 左下40 = UILabel()
        左下40.text = "40"
        Layout.regist(左下40, container: self.view)
            .bottom(d).fromContainerBottom()
            .left(d).fromContainerLeft()
            .backgroundColor(color)

        
        let 右下40 = UILabel()
        右下40.text = "40"
        Layout.regist(右下40, container: self.view)
            .bottom(d).fromContainerBottom()
            .right(d).fromContainerRight()
            .backgroundColor(color)


        
        //more
        let 左40 = UILabel()
        左40.text = "40"
        Layout.regist(左40, container: self.view)
            .verticalCenterIsSame(centerView)
            .leftIsSame(左上40)
            .backgroundColor(color)
        
        
        let 右40 = UILabel()
        右40.text = "40"
        Layout.regist(右40, container: self.view)
            .verticalCenterIsSame(centerView)
            .rightIsSame(右上40)
            .backgroundColor(color)
        
        
        let 上40 = UILabel()
        上40.text = "40"
        Layout.regist(上40, container: self.view)
            .topIsSame(左上40)
            .horizontalCenterIsSame(centerView)
            .backgroundColor(color)
        
        
        let 下40 = UILabel()
        下40.text = "40"
        Layout.regist(下40, container: self.view)
            .bottomIsSame(右下40)
            .horizontalCenterIsSame(centerView)
            .backgroundColor(color)
    }
    
    private func cornerViews(centerView:UIView) {
        
        let color = UIColor.greenColor()

        
        let lbl左上 = UILabel()
        lbl左上.text = "左上"
        Layout.regist(lbl左上, container: self.view)
            .topIsSameContainer()
            .leftIsSameContainer()
            .backgroundColor(color)
        
        
        let lbl右上 = UILabel()
        lbl右上.text = "右上"
        Layout.regist(lbl右上, container: self.view)
            .topIsSameContainer()
            .rightIsSameContainer()
            .backgroundColor(color)
        
        
        let lbl左下 = UILabel()
        lbl左下.text = "左下"
        Layout.regist(lbl左下, container: self.view)
            .bottomIsSameContainer()
            .leftIsSameContainer()
            .backgroundColor(color)
        
        
        let lbl右下 = UILabel()
        lbl右下.text = "右下"
        Layout.regist(lbl右下, container: self.view)
            .bottomIsSameContainer()
            .rightIsSameContainer()
            .backgroundColor(color)
        
        
        
        
        //more
        let lbl左 = UILabel()
        lbl左.text = "左"
        Layout.regist(lbl左, container: self.view)
            .verticalCenterIsSame(centerView)
            .leftIsSame(lbl左上)
            .backgroundColor(color)
        
        
        let lbl右 = UILabel()
        lbl右.text = "右"
        Layout.regist(lbl右, container: self.view)
            .verticalCenterIsSame(centerView)
            .rightIsSame(lbl右上)
            .backgroundColor(color)
        
        
        let lbl上 = UILabel()
        lbl上.text = "上"
        Layout.regist(lbl上, container: self.view)
            .topIsSame(lbl左上)
            .horizontalCenterIsSame(centerView)
            .backgroundColor(color)
        
        
        let lbl下 = UILabel()
        lbl下.text = "下"
        Layout.regist(lbl下, container: self.view)
            .bottomIsSame(lbl右下)
            .horizontalCenterIsSame(centerView)
            .backgroundColor(color)
    }

    
    var touchBlocks = TouchBlocks()
    
    private func addReturnBtn() {
        let btn = Layout.createSystemTypeBtn("return")
        Layout.regist(btn, container: self.view)
            .bottomIsSameContainer()
            .rightIsSameContainer()
        touchBlocks.append(btn){
            self.dismissViewControllerAnimated(true, completion:nil)
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
