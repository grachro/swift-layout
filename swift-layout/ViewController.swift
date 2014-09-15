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

        
        let sampleControllers:[(btn:UIButton, controller:UIViewController)] = [
            (Layout.createSystemTypeBtn("Auto Layout サンプルへ"), AutoLayoutSampleController()),
            (Layout.createSystemTypeBtn("横に等間隔 サンプルへ"), HorizontalEvenSpaceViewController()),
            (Layout.createSystemTypeBtn("縦に等間隔 サンプルへ"), VerticalEvenSpaceViewController()),
            (Layout.createSystemTypeBtn("条文形式画面へ"), AgreementViewController()),
            (Layout.createSystemTypeBtn("引っ張る1"), PullToRefresh1SampleViewController()),
            (Layout.createSystemTypeBtn("引っ張る2"), PullToRefresh2SampleViewController()),

        ]
        
        
        for t in sampleControllers {
            self.touchBlocks.append(t.btn) {
                self.presentViewController(t.controller, animated: true, completion: nil)
            }
            Layout.regist(t.btn, superview: self.view)
                .left(40).fromSuperviewLeft()
        }
        
        let btns = sampleControllers.reduce([]){(var u, var t) -> [UIButton] in
            u.append(t.btn)
            return u
        }
        
        Layout.verticalEvenSpaceInCotainer(superview: self.view, views: btns, coverSpace: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

