//
//  PullToRefresh1SampleViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/15.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class PullToRefresh1SampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let puller = ScrollViewPuller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maxHeight100:CGFloat = 100
        let autolayoutPullArea = AutolayoutPullArea(minHeight:0,maxHeight:maxHeight100,superview: self.tableView)
        autolayoutPullArea.layout
        
        let effectView = Layout.createLightBlurEffect()
        Layout.addSubView(effectView, superview: autolayoutPullArea.view)
            .rightIsSameSuperview()
            .leftIsSameSuperview()
            .topIsSameSuperview()
            .bottomIsSameSuperview()
        
        let text = UILabel()
        Layout.addSubView(text, superview: autolayoutPullArea.view)
            .text("中央")
            .horizontalCenterInSuperview()
            .verticalCenterInSuperview()
        
        var topBarConstraint:NSLayoutConstraint?
        let topBar = UIView()
        Layout.addSubView(topBar, superview: autolayoutPullArea.view)
            .rightIsSameSuperview()
            .leftIsSameSuperview()
            .height(20).lastConstraint(&topBarConstraint)
            .topIsSameSuperview()
            .backgroundColor(UIColor(red:0.50,green:0.50,blue:0.50,alpha:1.0))
        
        
        var bar1HeightConstraint:NSLayoutConstraint?
        let bar1 = UIView()
        Layout.addSubView(bar1, superview: autolayoutPullArea.view)
            .width(50)
            .bottomIsSameSuperview()
            .height(70).lastConstraint(&bar1HeightConstraint)
            .left(40).fromSuperviewLeft()
            .backgroundColor(UIColor(red:0.82,green:0.71,blue:0.55,alpha:1.0))
        
        var bar2HeightConstraint:NSLayoutConstraint?
        let bar2 = UIView()
        Layout.addSubView(bar2, superview: autolayoutPullArea.view)
            .width(50)
            .bottomIsSameSuperview()
            .height(50).lastConstraint(&bar2HeightConstraint)
            .right(40).fromSuperviewRight()
            .backgroundColor(UIColor(red:0.82,green:0.71,blue:0.55,alpha:1.0))
        
        
        
        autolayoutPullArea.pullCallback = {(areaHeight: CGFloat, pullAreaHeight: CGFloat) in
            text.isHidden = areaHeight < 20
            
            if areaHeight < 40 {
                topBarConstraint?.constant = 20 - (40 - areaHeight) / 2
            } else {
                topBarConstraint?.constant = 20
            }
            
            let percent = areaHeight / maxHeight100
            bar1HeightConstraint?.constant = 70 * percent
            bar2HeightConstraint?.constant = 50 * percent
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
            .backgroundColor(UIColor(red:0.94,green:0.50,blue:0.50,alpha:1.0))
        
        let footer = Layout.createSystemTypeBtn("return")
        Layout.addSubView(footer, superview: self.view)
            .leftIsSameSuperview()
            .rightIsSameSuperview()
            .bottomIsSameSuperview()
            .height(50)
            .backgroundColor(UIColor(red:0.94,green:0.50,blue:0.50,alpha:1.0))
            .textColor(UIColor.white)
        
        Layout.addSubView(tableView, superview: self.view)
            .leftIsSameSuperview()
            .rightIsSameSuperview()
            .top(0).fromBottom(header)
            .bottom(0).fromTop(footer)
            .backgroundColor(UIColor.lightGray)
        
        
        footer.addTarget(self, action: "goview2", for: UIControlEvents.touchUpInside)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            cell.textLabel?.text = "下に引っ張る"
        } else {
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    
    //スクロール開始
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.puller.beginDragScroll(scrollView)
    }
    
    //スクロール終了
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.puller.endDragScroll(scrollView, willDecelerate: decelerate)
    }
    
    //
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)  {
        self.puller.endScroll(scrollView)
    }
    
    //スクロール中
    //UITableViewDelegate:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.puller.dragScroll(scrollView)
    }
    
    
    func goview2() {
        self.dismiss(animated: true, completion:nil)
    }
}

