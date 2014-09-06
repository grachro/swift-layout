//
//  Layout.swift
//  swift-layout
//
//  Created by grachro on 2014/09/06.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit


class LayoutTopFrom {
    private let _layout:Layout
    private let _size:CGFloat
    
    init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    func fromTopOf(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Top, relatedBy: .Equal, toItem: base, attribute: .Top, multiplier: 1.0, constant: self._size)
        self._layout._layouts.append(l)
        return self._layout
    }
    
    func fromBottomOf(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Top, relatedBy: .Equal, toItem: base, attribute: .Bottom, multiplier: 1.0, constant: self._size)
        self._layout._layouts.append(l)
        return self._layout
    }
}

class LayoutLeftFrom {
    private let _layout:Layout
    private let _size:CGFloat
    
    init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    
    func fromLeftOf(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Left, relatedBy: .Equal, toItem: base, attribute: .Left, multiplier: 1.0, constant: self._size)
        self._layout._layouts.append(l)
        return self._layout
    }
}

class LayoutRightFrom {
    private let _layout:Layout
    private let _size:CGFloat
    
    init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    
    func fromRightOf(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Right, relatedBy: .Equal, toItem: base, attribute: .Right, multiplier: 1.0, constant: -self._size)
        self._layout._layouts.append(l)
        return self._layout
    }
}


class Layout {
    
    private let target:UIView
    private var _layouts:[NSLayoutConstraint] = []
    
    var layouts:[NSLayoutConstraint] {
        get{
            return _layouts
        }
    }
    
    init(view:UIView) {
        self.target = view
    }
    
    
    func topFrom(size:CGFloat) -> LayoutTopFrom {
        return LayoutTopFrom(layout: self, size: size)
    }
    
    func leftFrom(size:CGFloat) -> LayoutLeftFrom {
        return LayoutLeftFrom(layout: self, size: size)
    }
    
    func rightFrom(size:CGFloat) -> LayoutRightFrom {
        return LayoutRightFrom(layout: self, size: size)
    }
}
