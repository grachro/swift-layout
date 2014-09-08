//
//  ViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/06.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var touchBlocks = TouchBlocks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let btn1 = Layout.createSystemTypeBtn("サンプル画面1へ")
        self.touchBlocks.append(btn1) {
            self.presentViewController(Sample1ViewController(), animated: true, completion: nil)
        }
        Layout.regist(btn1, container: self.view)
            .left(40).fromContainerLeft()
        
        
        
        let btn2 = Layout.createSystemTypeBtn("横に等間隔（両端にスペースあり）")
        self.touchBlocks.append(btn2) {
            self.presentViewController(Sample2ViewController(), animated: true, completion: nil)
        }
        Layout.regist(btn2, container: self.view)
            .leftIsSame(btn1)

        
        
        let btn3 = Layout.createSystemTypeBtn("横に等間隔（両端にスペースなし）")
        self.touchBlocks.append(btn3) {
            self.presentViewController(Sample3ViewController(), animated: true, completion: nil)
        }
        Layout.regist(btn3, container: self.view)
            .leftIsSame(btn1)
        
        
        
        let btn4 = Layout.createSystemTypeBtn("縦に等間隔")
        self.touchBlocks.append(btn4) {
            self.presentViewController(Sample4ViewController(), animated: true, completion: nil)
        }
        Layout.regist(btn4, container: self.view)
            .leftIsSame(btn1)
        
        
        
        let btn5 = Layout.createSystemTypeBtn("条文形式画面へ")
        self.touchBlocks.append(btn5) {
            self.presentViewController(AgreementViewController(), animated: true, completion: nil)
        }
        Layout.regist(btn5, container: self.view)
            .leftIsSame(btn1)
        
        
        
        Layout.verticalEvenSpaceInCotainer(container: self.view, views: [btn1,btn2,btn3,btn4,btn5], coverSpace: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

