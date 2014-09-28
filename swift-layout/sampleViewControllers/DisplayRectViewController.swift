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
        
 
        let viewA = Layout.registUIView(superview: self.view)
            .left(10).fromSuperviewLeft()
            .top(10).fromSuperviewTop()
            .width(100)
            .height(50)
            .backgroundColor(UIColor.redColor())
        
        let subView = Layout.registUIView(superview: viewA.view)
            .left(30).fromSuperviewLeft()
            .top(15).fromSuperviewTop()
            .width(20)
            .height(20)
            .backgroundColor(UIColor.blueColor())
        
 
        println(subView.displayRect())
     
        
        let layout = Layout.registUILabel(superview: self.view)
            .text("赤枠の画面上の座標\(viewA.displayRect())")
            .top(10).fromBottom(viewA.view)
            .left(10).fromSuperviewLeft()
        
        Layout.registUILabel(superview: self.view)
            .text("青枠の画面上の座標\(subView.displayRect())")
            .top(10).fromBottom(layout.view)
            .left(10).fromSuperviewLeft()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
