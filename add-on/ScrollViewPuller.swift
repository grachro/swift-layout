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
    func animationSpeed() -> NSTimeInterval
    func show(#viewHeight:CGFloat, pullAreaHeight:CGFloat)
}

class ScrollViewPuller {
    
    private var target:UIScrollView? = nil
    
    private var pullArea:ScrollViewPullArea? = nil
    private var pullAreaHeight:CGFloat = 0
    
    private var lastScrollViewOffsetY:CGFloat = 0
    private var draggingDistance:CGFloat = 0
    private var isDrag = false
    
    private var isPull:Bool {
        get {
            return (scrollHeight < 0) //引っ張り中?
        }
    }
    
    private var isUpWay:Bool {
        get {
            return (draggingDistance < 0) //上に移動中
        }
    }
    
    private var isDownWay:Bool {
        get {
            return (0 < draggingDistance) //下に移動中
        }
    }
    
    private var scrollHeight:CGFloat {
        get {
            if self.target == nil {
                return 0
            }
            return self.target!.contentOffset.y
        }
    }
    
}

extension ScrollViewPuller {
    
    func begin(target:UIScrollView, pullArea:ScrollViewPullArea) {
        self.target = target
        self.pullArea = pullArea
        self.minDisplay()
    }
    
    
    //ドラッグスクロール開始
    //call from scrollViewWillBeginDragging(scrollView: UIScrollView!)
    func beginDragScroll(scrollView: UIScrollView!) {
        self.isDrag=true
    }
    
    //ドラッグスクロール終了
    //call from scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool)
    func endDragScroll(scrollView: UIScrollView!!, willDecelerate decelerate: Bool) {
        
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
    func endScroll(scrollView: UIScrollView!) {
        
        let offsetY = self.target!.contentOffset.y
        if self.pullArea!.maxHeight() <= -offsetY {
            maxDisplay()
        } else if self.pullArea!.minHeight() != offsetY {
            minDisplay()
        }
        
    }
    
    //スクロール中
    //call from scrollViewDidScroll(scrollView: UIScrollView!)
    func dragScroll(scrollView: UIScrollView!) {
        
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
    
    private func changeDragginAndPulling() {
        
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
    
    
    private func display(height:CGFloat,needFullOpen:Bool) {
        UIView.animateWithDuration(self.pullArea!.animationSpeed(), animations: {
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
    
    private func minDisplay() {
        display(self.pullArea!.minHeight(), needFullOpen:false)
    }
    
    private func maxDisplay() {
        display(self.pullArea!.maxHeight(), needFullOpen:true)
    }
    
}

