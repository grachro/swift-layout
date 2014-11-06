//
//  BlurEffectViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/15.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class BlurEffectViewController: UIViewController {

    //磨りガラス効果
    let extraLight = Layout.createExtraLightBlurEffect()
    let light = Layout.createLightBlurEffect()
    let dark = Layout.createDarkBlurEffect()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //背景
        var text1 = Layout.createCharWrappingLabel("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        Layout.addSubView(text1, superview: self.view)
            .font(UIFont.systemFontOfSize(20))
            .width(120)
            .top(20).fromSuperviewTop()
            .horizontalCenterInSuperview()

        var text2 = Layout.createCharWrappingLabel("ABCDEFG")
        Layout.addSubView(text2, superview: self.view)
            .font(UIFont.boldSystemFontOfSize(40))
            .textColor(UIColor.redColor())
            .width(120)
            .top(20).fromBottom(text1)
            .horizontalCenterInSuperview()
        
      
        //磨りガラス配置
        Layout.addSubView(extraLight, superview: self.view)
            .coverSuperView()
        
        Layout.addSubView(light, superview: self.view)
            .coverSuperView()
            .hide()
        
        
        Layout.addSubView(dark, superview: self.view)
            .coverSuperView()
            .hide()

        
        //磨りガラス変更ボタン
        let extraLightBtn = Layout.createSystemTypeBtn("ExtraLight")
        Layout.addSubView(extraLightBtn, superview: self.view)
            .bottom(20).fromSuperviewBottom()
            .left(10).fromSuperviewLeft()
            .touchUpInside({self.toggle(0)})
        
        let lightBtn = Layout.createSystemTypeBtn("Light")
        Layout.addSubView(lightBtn, superview: self.view)
            .bottom(20).fromSuperviewBottom()
            .left(10).fromRight(extraLightBtn)
            .touchUpInside({self.toggle(1)})
    

        let darkBtn = Layout.createSystemTypeBtn("Dark")
        Layout.addSubView(darkBtn, superview: self.view)
            .bottom(20).fromSuperviewBottom()
            .left(10).fromRight(lightBtn)
            .touchUpInside({self.toggle(2)})

        let nothigBtn = Layout.createSystemTypeBtn("nothing")
        Layout.addSubView(nothigBtn, superview: self.view)
            .bottom(20).fromSuperviewBottom()
            .left(10).fromRight(darkBtn)
            .touchUpInside({self.toggle(3)})

    
        
        

        //戻るボタン
        let btn = Layout.createSystemTypeBtn("return")
        Layout.addSubView(btn, superview: self.view)
            .bottomIsSameSuperview()
            .rightIsSameSuperview()
            .touchUpInside({self.dismissViewControllerAnimated(true, completion:nil)})
        
   
    }

    func toggle(id:Int) {
        
        switch id {
            
        case 0:
                Layout.more(self.extraLight).show();
                Layout.more(self.light).hide();
                Layout.more(self.dark).hide()
            
        case 1:
                Layout.more(self.extraLight).hide();
                Layout.more(self.light).show();
                Layout.more(self.dark).hide()
            
        case 2:
                Layout.more(self.extraLight).hide();
                Layout.more(self.light).hide();
                Layout.more(self.dark).show()
            
        default :
                Layout.more(self.extraLight).hide();
                Layout.more(self.light).hide();
                Layout.more(self.dark).hide()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
