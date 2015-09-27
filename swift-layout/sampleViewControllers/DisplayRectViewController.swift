//
//  DisplayRectViewController
//  swift-layout
//
//  Created by grachro on 2014/09/23.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class DisplayRectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
 
        let viewA = Layout.addUIView(superview: self.view)
            .left(10).fromSuperviewLeft()
            .top(10).fromSuperviewTop()
            .width(100)
            .height(50)
            .backgroundColor(UIColor.redColor())
        
        let subView = Layout.addUIView(superview: viewA.view)
            .left(30).fromSuperviewLeft()
            .top(15).fromSuperviewTop()
            .width(20)
            .height(20)
            .backgroundColor(UIColor.blueColor())
        
 
        print(subView.displayRect())
     
        
        let layout = Layout.addUILabel(superview: self.view)
            .text("赤枠の画面上の座標\(viewA.displayRect())")
            .top(10).fromBottom(viewA.view)
            .left(10).fromSuperviewLeft()
        
        Layout.addUILabel(superview: self.view)
            .text("青枠の画面上の座標\(subView.displayRect())")
            .top(10).fromBottom(layout.view)
            .left(10).fromSuperviewLeft()
        
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
    }

}
