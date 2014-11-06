//
//  PullToRefresh2SampleViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/15.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class PullToRefresh2SampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let puller = ScrollViewPuller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minHeight20:CGFloat = 20
        let maxHeight100:CGFloat = 100
        let autolayoutPullArea = AutolayoutPullArea(minHeight:minHeight20, maxHeight:maxHeight100, superview:self.tableView)
        autolayoutPullArea.layout
            .backgroundColor(UIColor(red:1.00, green:0.48, blue:1.00, alpha:0.3))
        
        
        let text = UILabel()
        Layout.addSubView(text, superview: autolayoutPullArea.view)
            .text("中央")
            .horizontalCenterInSuperview()
            .verticalCenterInSuperview()
        
        
        let pullAreaBar = UILabel()
        Layout.addSubView(pullAreaBar, superview: autolayoutPullArea.view)
            .text("下に引っ張る")
            .rightIsSameSuperview()
            .leftIsSameSuperview()
            .height(minHeight20)
            .bottomIsSameSuperview()
            .backgroundColor(UIColor(red:0.44, green:0.35, blue:0.64, alpha:1.0))
        
        var bar1HeightConstraint:NSLayoutConstraint?
        let bar1 = Layout.addSubView(UIView(), superview: autolayoutPullArea.view)
            .width(50)
            .bottom(0).fromTop(pullAreaBar)
            .height(70).lastConstraint(&bar1HeightConstraint)
            .left(40).fromSuperviewLeft()
            .backgroundColor(UIColor(red:0.48, green:1.00, blue:0.74, alpha:0.4))
        
        var bar2HeightConstraint:NSLayoutConstraint?
        let bar2 = Layout.addSubView(UIView(), superview: autolayoutPullArea.view)
            .width(50)
            .bottom(0).fromTop(pullAreaBar)
            .height(50).lastConstraint(&bar2HeightConstraint)
            .right(40).fromSuperviewRight()
            .backgroundColor(UIColor(red:0.48, green:1.00, blue:0.74, alpha:0.4))
        
        
        
        autolayoutPullArea.pullCallback = {(areaHeight: CGFloat, pullAreaHeight: CGFloat) in
            text.hidden = areaHeight < 20
            
            let percent = areaHeight / maxHeight100
            let percentPull = pullAreaHeight / maxHeight100
            
            
            bar1HeightConstraint?.constant = 70 * percent
            bar2HeightConstraint?.constant = 50 * percent
            
            
            bar1.backgroundColorAlpha(0.4 * percentPull)
            bar2.backgroundColorAlpha(0.4 * percentPull)
            
        }
        
        puller.begin(self.tableView, pullArea:autolayoutPullArea)
        
        createBaseView()
    }
    
    func createBaseView() {
        
        let header = UIView()
        Layout.addSubView(header, superview: self.view)
            .leftIsSameSuperview()
            .rightIsSameSuperview()
            .topIsSameSuperview()
            .height(50)
            .backgroundColor(UIColor(red:0.86, green:0.87, blue:0.87, alpha:1.0))


        let footer = Layout.createSystemTypeBtn("return")
        Layout.addSubView(footer, superview: self.view)
            .leftIsSameSuperview()
            .rightIsSameSuperview()
            .bottomIsSameSuperview()
            .height(50)
            .backgroundColor(UIColor(red:0.86, green:0.87, blue:0.87, alpha:1.0))
            .textColor(UIColor.blackColor())
 

        Layout.addSubView(tableView, superview: self.view)
            .leftIsSameSuperview()
            .rightIsSameSuperview()
            .top(0).fromBottom(header)
            .bottom(0).fromTop(footer)
            .backgroundColor(UIColor.lightGrayColor())
        
        footer.addTarget(self, action: "goview1", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
    //スクロール開始
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        self.puller.beginDragScroll(scrollView)
    }
    
    //スクロール終了
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
        self.puller.endDragScroll(scrollView, willDecelerate: decelerate)
    }
    
    //スクロール終了（慣性移動）
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!)  {
        self.puller.endScroll(scrollView)
    }
    
    //スクロール中
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        self.puller.dragScroll(scrollView)
    }
    
    
    func goview1() {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
}

