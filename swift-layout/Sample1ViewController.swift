//
//  Sample1ViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/07.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class Sample1ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let lbl左上 = UILabel()
        lbl左上.text = "左上"
        Layout.regist(lbl左上, container: self.view)
            .top(20).fromContainerTop()
            .left(20).fromContainerLeft()
        
        
        let lbl右上 = UILabel()
        lbl右上.text = "右上"
        Layout.regist(lbl右上, container: self.view)
            .top(20).fromContainerTop()
            .right(20).fromContainerRight()
        
        
        let lbl左下 = UILabel()
        lbl左下.text = "左下"
        Layout.regist(lbl左下, container: self.view)
            .bottom(20).fromContainerBottom()
            .left(20).fromContainerLeft()
        
        
        let lbl右下 = UILabel()
        lbl右下.text = "右下"
        Layout.regist(lbl右下, container: self.view)
            .bottom(20).fromContainerBottom()
            .right(20).fromContainerRight()
        

        let lbl中央 = UILabel()
        lbl中央.text = "中央"
        Layout.regist(lbl中央, container: self.view)
            .horizontalCenterInContainer()
            .verticalCenterInContainer()
        
        
        
        
        //more
        let lbl左 = UILabel()
        lbl左.text = "左"
        Layout.regist(lbl左, container: self.view)
            .verticalCenterIsSame(lbl中央)
            .leftIsSame(lbl左上)
        
        
        let lbl右 = UILabel()
        lbl右.text = "右"
        Layout.regist(lbl右, container: self.view)
            .verticalCenterIsSame(lbl中央)
            .rightIsSame(lbl右上)
        
        let lbl上 = UILabel()
        lbl上.text = "上"
        Layout.regist(lbl上, container: self.view)
            .topIsSame(lbl左上)
            .horizontalCenterIsSame(lbl中央)
        
        let lbl下 = UILabel()
        lbl下.text = "下"
        Layout.regist(lbl下, container: self.view)
            .bottomIsSame(lbl右下)
            .horizontalCenterIsSame(lbl中央)
    
        //戻るボタン
        addReturnBtn()
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
    }
    

}
