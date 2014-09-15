//
//  AutolayoutPullArea.swift
//  swift-layout
//
//  Created by grachro on 2014/09/15.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit


class AutolayoutPullArea:ScrollViewPullArea {
    
    private var _minHeight:CGFloat
    private var _maxHeight:CGFloat
    
    var topConstraint:NSLayoutConstraint?
    var headerConstraint:NSLayoutConstraint?
    
    let view = UIView()
    private var _layout:Layout?
    var layout:Layout {
        get {return _layout!}
    }
    
    var pullCallback:((viewHeight:CGFloat, pullAreaHeight:CGFloat) -> Void)? = nil
    
    init(minHeight:CGFloat, maxHeight:CGFloat, superview:UIView) {
        
        self._minHeight = minHeight
        self._maxHeight = maxHeight
        
        _layout = Layout.regist(view, superview: superview)
            .horizontalCenterInContainer()
            .leftIsSameContainer()
            .rightIsSameContainer()
            .top(-self._maxHeight).fromContainerTop().lastConstraint(&topConstraint)
            .height(self._maxHeight).lastConstraint(&headerConstraint)
        
    }
}

//implements ScrollViewPullArea
extension AutolayoutPullArea {
    
    func minHeight() -> CGFloat {
        return _minHeight
    }
    
    func maxHeight() -> CGFloat {
        return _maxHeight
    }
    
    func animationSpeed() -> NSTimeInterval {
        return 0.4
    }
    
    func show(#viewHeight:CGFloat, pullAreaHeight:CGFloat) {
        
        if viewHeight < pullAreaHeight {
            self.topConstraint?.constant = -((pullAreaHeight - viewHeight) / 2 + viewHeight)
        } else {
            self.topConstraint?.constant = -viewHeight
        }
        
        self.headerConstraint?.constant = viewHeight
        view.superview?.layoutIfNeeded()
        
        self.pullCallback?(viewHeight: viewHeight, pullAreaHeight:pullAreaHeight)
        view.layoutIfNeeded()
        
    }
}

