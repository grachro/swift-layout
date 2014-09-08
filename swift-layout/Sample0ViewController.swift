//
//  Sample0ViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/08.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class Sample0ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let 起点 = UILabel()
        起点.text = "起点"
        Layout.regist(起点, container: self.view)
            .horizontalCenterInContainer()
            .verticalCenterInContainer()
        
        
        let 右 = UILabel()
        右.text = "右"
        Layout.regist(右, container: self.view)
            .left(20).fromRight(起点)
            .verticalCenterIsSame(起点)
        
        let 左 = UILabel()
        左.text = "左"
        Layout.regist(左, container: self.view)
            .right(20).fromLeft(起点)
            .verticalCenterIsSame(起点)
        
        let 上 = UILabel()
        上.text = "上"
        Layout.regist(上, container: self.view)
            .bottom(20).fromTop(起点)
            .horizontalCenterIsSame(起点)
        
        let 下 = UILabel()
        下.text = "下"
        Layout.regist(下, container: self.view)
            .top(20).fromBottom(起点)
            .horizontalCenterIsSame(起点)
        
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
        // Dispose of any resources that can be recreated.
    }
    

}
