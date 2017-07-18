//
//  ViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/06.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let sampleControllers:[(btn:UIButton, controller:UIViewController)] = [
            (Layout.createSystemTypeBtn("Auto Layout サンプルへ"), AutoLayoutSampleController()),
            (Layout.createSystemTypeBtn("横に等間隔 サンプルへ"), HorizontalEvenSpaceViewController()),
            (Layout.createSystemTypeBtn("縦に等間隔 サンプルへ"), VerticalEvenSpaceViewController()),
            (Layout.createSystemTypeBtn("条文形式画面へ"), AgreementViewController()),
            (Layout.createSystemTypeBtn("磨りガラス効果へ"), BlurEffectViewController()),
            (Layout.createSystemTypeBtn("引っ張る1"), PullToRefresh1SampleViewController()),
            (Layout.createSystemTypeBtn("引っ張る2"), PullToRefresh2SampleViewController()),
            (Layout.createSystemTypeBtn("SubViewの座標"), DisplayRectViewController()),
            (Layout.createSystemTypeBtn("角丸各種"), RoundedRectViewController()),
            (Layout.createSystemTypeBtn("ScrollViewにWordWrappingラベル"), ScrollViewAndWordWrappingLabelController()),
        ]
        
        
        for t in sampleControllers {
            TouchBlocks.append(t.btn) {
                self.present(t.controller, animated: true, completion: nil)
            }
            Layout.addSubView(t.btn, superview: self.view)
                .left(20).fromSuperviewLeft()
        }
        
        let btns = sampleControllers.reduce([]){(u, t) -> [UIButton] in
            u.append(t.btn)
            return u
        }
        
        Layout.verticalEvenSpaceInCotainer(superview: self.view, views: btns, coverSpace: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

