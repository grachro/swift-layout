//
//  ScrollViewPuller.swift
//  swift-layout
//
//  Created by grachro on 2014/09/15.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit


protocol ScrollViewPullArea {
    func minHeight() -> CGFloat
    func maxHeight() -> CGFloat
    func animationSpeed() -> TimeInterval
    func show(viewHeight:CGFloat, pullAreaHeight:CGFloat)
}

class ScrollViewPuller {
    
    fileprivate var target:UIScrollView? = nil
    
    fileprivate var pullArea:ScrollViewPullArea? = nil
    fileprivate var pullAreaHeight:CGFloat = 0
    
    fileprivate var lastScrollViewOffsetY:CGFloat = 0
    fileprivate var draggingDistance:CGFloat = 0
    fileprivate var isDrag = false
    
    fileprivate var isPull:Bool {
        get {
            return (scrollHeight < 0) //引っ張り中?
        }
    }
    
    fileprivate var isUpWay:Bool {
        get {
            return (draggingDistance < 0) //上に移動中
        }
    }
    
    fileprivate var isDownWay:Bool {
        get {
            return (0 < draggingDistance) //下に移動中
        }
    }
    
    fileprivate var scrollHeight:CGFloat {
        get {
            if self.target == nil {
                return 0
            }
            return self.target!.contentOffset.y
        }
    }
    
}

extension ScrollViewPuller {
    
    func begin(_ target:UIScrollView, pullArea:ScrollViewPullArea) {
        self.target = target
        self.pullArea = pullArea
        self.minDisplay()
    }
    
    
    //ドラッグスクロール開始
    //call from scrollViewWillBeginDragging(scrollView: UIScrollView!)
    func beginDragScroll(_ scrollView: UIScrollView!) {
        self.isDrag=true
    }
    
    //ドラッグスクロール終了
    //call from scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool)
    func endDragScroll(_ scrollView: UIScrollView?!, willDecelerate decelerate: Bool) {
        
        if self.target == nil {
            return
        }
        
        self.isDrag=false
        
        if isDownWay {
            //println("下,isPull=\(isPull)")
        }
        if isUpWay {
            //println("上,isPull=\(isPull)")
        }
        
        if isDownWay && isPull {
            
            let needFullOpen = self.pullAreaHeight < self.pullArea!.maxHeight()
            
            self.pullAreaHeight = self.pullArea!.maxHeight()
            self.display(self.pullAreaHeight, needFullOpen: needFullOpen)
            
        } else if isUpWay && 0 < self.pullAreaHeight {
            self.pullAreaHeight = self.pullArea!.minHeight()
            if decelerate {
                //慣性移動中
                return
            }
            minDisplay()
        }
        
    }
    
    //慣性スクロール終了(this event is after endDragScroll())
    //call from scrollViewDidEndDecelerating(scrollView: UIScrollView!)
    func endScroll(_ scrollView: UIScrollView!) {
        
        let offsetY = self.target!.contentOffset.y
        if self.pullArea!.maxHeight() <= -offsetY {
            maxDisplay()
        } else if self.pullArea!.minHeight() != offsetY {
            minDisplay()
        }
        
    }
    
    //スクロール中
    //call from scrollViewDidScroll(scrollView: UIScrollView!)
    func dragScroll(_ scrollView: UIScrollView!) {
        
        if self.target == nil {
            return
        }
        
        
        if self.isDrag {
            self.draggingDistance = self.lastScrollViewOffsetY - self.scrollHeight
        } else {
            self.draggingDistance = 0
        }
        
        changeDragginAndPulling()
        
        self.lastScrollViewOffsetY = self.scrollHeight
    }
    
    fileprivate func changeDragginAndPulling() {
        
        if self.target == nil {
            return
        }
        
        if !self.isDrag || !isPull {
            return
        }
        
        self.pullAreaHeight = -self.scrollHeight
        if self.pullAreaHeight < self.pullArea!.minHeight() {
            self.pullAreaHeight = self.pullArea!.minHeight()
        } else if self.pullAreaHeight > self.pullArea!.maxHeight() {
            self.pullAreaHeight = self.pullArea!.maxHeight()
        }
        
        self.target!.contentInset.top = self.pullAreaHeight
        if self.pullArea != nil {
            self.pullArea!.show(viewHeight:self.pullAreaHeight,pullAreaHeight:-self.scrollHeight)
        }
    }
    
    
    fileprivate func display(_ height:CGFloat,needFullOpen:Bool) {
        UIView.animate(withDuration: self.pullArea!.animationSpeed(), animations: {
            var inset = self.target!.contentInset
            inset.top = height
            self.target!.contentInset = inset
            
            if needFullOpen {
                self.target!.contentOffset.y = -height
            }
            
            if self.pullArea != nil {
                self.pullArea!.show(viewHeight:height, pullAreaHeight:height)
            }
            
        })
    }
    
    fileprivate func minDisplay() {
        display(self.pullArea!.minHeight(), needFullOpen:false)
    }
    
    fileprivate func maxDisplay() {
        display(self.pullArea!.maxHeight(), needFullOpen:true)
    }
    
}

