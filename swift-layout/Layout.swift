//
//  Layout.swift
//  swift-layout
//
//  Created by grachro on 2014/09/06.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit


class LayoutTop {
    private let _layout:Layout
    private let _size:CGFloat
    
    private init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    func fromTop(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Top, relatedBy: .Equal, toItem: base, attribute: .Top, multiplier: 1.0, constant: self._size)
        self._layout.container.addConstraint(l)
        return self._layout
    }

    func fromContainerTop() -> Layout{
        return fromTop(self._layout.container)
    }
    
    func fromBottom(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Top, relatedBy: .Equal, toItem: base, attribute: .Bottom, multiplier: 1.0, constant: self._size)
        self._layout.container.addConstraint(l)
        return self._layout
    }

}


class LayoutBottom {
    private let _layout:Layout
    private let _size:CGFloat
    
    private init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    func fromBottom(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Bottom, relatedBy: .Equal, toItem: base, attribute: .Bottom, multiplier: 1.0, constant: -self._size)
        self._layout.container.addConstraint(l)
        return self._layout
    }
    
    func fromContainerBottom() -> Layout{
        return fromBottom(self._layout.container)
    }

}


class LayoutLeft {
    private let _layout:Layout
    private let _size:CGFloat
    
    private init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    
    func fromLeft(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Left, relatedBy: .Equal, toItem: base, attribute: .Left, multiplier: 1.0, constant: self._size)
        self._layout.container.addConstraint(l)
        return self._layout
    }
    
    func fromRight(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Left, relatedBy: .Equal, toItem: base, attribute: .Right, multiplier: 1.0, constant: self._size)
        self._layout.container.addConstraint(l)
        return self._layout
    }
    
    func fromContainerLeft() -> Layout {
        return fromLeft(self._layout.container)
    }
}

class LayoutRight {
    private let _layout:Layout
    private let _size:CGFloat
    
    private init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    func fromLeft(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Right, relatedBy: .Equal, toItem: base, attribute: .Left, multiplier: 1.0, constant: -self._size)
        self._layout.container.addConstraint(l)
        return self._layout
    }
    
    func fromRight(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout.target, attribute: .Right, relatedBy: .Equal, toItem: base, attribute: .Right, multiplier: 1.0, constant: -self._size)
        self._layout.container.addConstraint(l)
        return self._layout
    }
    
    func fromContainerRight() -> Layout{
        return fromRight(self._layout.container)
    }
}


class Layout {
    
    class func more(view:UIView, container:UIView) -> Layout {
        return Layout(view: view, container: container)
    }
    
    class func regist(view:UIView, container:UIView) -> Layout {
        let layout = more(view, container: container)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(view)
        return layout
    }
    
    private let target:UIView
    private let container:UIView
    
    private init(view:UIView, container:UIView) {
        self.target = view
        self.container = container
    }
    
    
    func top(size:CGFloat) -> LayoutTop {
        return LayoutTop(layout: self, size: size)
    }
    
    func topIsSame(base:UIView) -> Layout {
        return LayoutTop(layout: self, size: 0).fromTop(base)
    }
    
    func topIsSameContainer() -> Layout {
        return topIsSame(self.container)
    }

    func bottom(size:CGFloat) -> LayoutBottom {
        return LayoutBottom(layout: self, size: size)
    }

    func bottomIsSame(base:UIView) -> Layout {
        return LayoutBottom(layout: self, size: 0).fromBottom(base)
    }

    func bottomIsSameContainer() -> Layout {
        return bottomIsSame(self.container)
    }

    func left(size:CGFloat) -> LayoutLeft {
        return LayoutLeft(layout: self, size: size)
    }
    
    func leftIsSame(base:UIView) -> Layout {
        return LayoutLeft(layout: self, size: 0).fromLeft(base)
    }
    
    func leftIsSameContainer() -> Layout {
        return leftIsSame(self.container)
    }

    func right(size:CGFloat) -> LayoutRight {
        return LayoutRight(layout: self, size: size)
    }

    func rightIsSame(base:UIView) -> Layout {
        return LayoutRight(layout: self, size: 0).fromRight(base)
    }
    
    func rightIsSameContainer() -> Layout {
        return rightIsSame(self.container)
    }

    func width(size:CGFloat) -> Layout {
        let l =  NSLayoutConstraint(item: self.target, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size)
        self.container.addConstraint(l)
        return self
    }
    
    func widthIsSame(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self.target, attribute: .Width, relatedBy: .Equal, toItem: base, attribute: .Width, multiplier: 1.0, constant: 0)
        self.container.addConstraint(l)
        return self
    }
    
    func height(size:CGFloat) -> Layout {
        let l =  NSLayoutConstraint(item: self.target, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size)
        self.container.addConstraint(l)
        return self
    }
    
    func heightIsSame(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self.target, attribute: .Height, relatedBy: .Equal, toItem: base, attribute: .Height, multiplier: 1.0, constant: 0)
        self.container.addConstraint(l)
        return self
    }
    
    func horizontalCenterIsSame(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: base, attribute: .CenterX, relatedBy: .Equal, toItem: self.target, attribute: .CenterX, multiplier: 1.0, constant: 0)
        self.container.addConstraint(l)
        return self
    }
    
    func verticalCenterIsSame(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: base, attribute: .CenterY, relatedBy: .Equal, toItem: self.target, attribute: .CenterY, multiplier: 1.0, constant: 0)
        self.container.addConstraint(l)
        return self
    }
    
    
    func horizontalCenterInContainer() -> Layout {
        let l =  NSLayoutConstraint(item: self.target, attribute: .CenterX, relatedBy: .Equal, toItem: self.container, attribute: .CenterX, multiplier: 1.0, constant: 0)
        self.container.addConstraint(l)
        return self
    }
    
    func verticalCenterInContainer() -> Layout {
        let l =  NSLayoutConstraint(item: self.target, attribute: .CenterY, relatedBy: .Equal, toItem: self.container, attribute: .CenterY, multiplier: 1.0, constant: 0)
        self.container.addConstraint(l)
        return self
    }
}

//horizontalEvenSpace
extension Layout {
    
    
    private class func addFirstForH(container:UIView, base:UIView, first:UIView) {
        let l =  NSLayoutConstraint(item: base, attribute: .Leading, relatedBy: .Equal, toItem: first, attribute: .Leading, multiplier: 1.0, constant: 0)
        container.addConstraint(l)
    }
    
    private class func addNextSpaceForH(container:UIView, target:UIView, spacer:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .Leading, relatedBy: .LessThanOrEqual, toItem: target, attribute: .Trailing, multiplier: 1.0, constant: 8)
        container.addConstraint(l)
    }
    
    private class func addLastForH(container:UIView, spacer:UIView, base:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .Trailing, relatedBy: .Equal, toItem: base, attribute: .Trailing, multiplier: 1.0, constant: 0)
        container.addConstraint(l)
    }

    
    class func horizontalEvenSpaceInCotainer(#container:UIView ,views:[UIView],coverSpace:Bool) {
        if coverSpace {
            horizontalEvenSpaceCoverSpaces(container: container, leadingView: container, trailingView: container, views: views)
        } else {
            horizontalEvenSpaceNotCoverSpaces(container: container, leadingView: container, trailingView: container, views: views)
        }
    }
    
    class func horizontalEvenSpaceNotCoverSpaces(#container:UIView ,leadingView:UIView, trailingView:UIView,views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0..<views.count-1 {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.regist(spacers[i], container: container)
                    .verticalCenterIsSame(views[0])
                    .height(10)
            } else {
                Layout.regist(spacers[i], container: container)
                    .verticalCenterIsSame(views[0])
                    .widthIsSame(spacers[0])
                    .height(10)
            }
        }
        
        Layout.addFirstForH(container, base: leadingView, first: views[0])
        for i in 0..<views.count-1 {
            Layout.addNextSpaceForH(container, target: views[i], spacer: spacers[i])
            Layout.addNextSpaceForH(container, target: spacers[i], spacer: views[i+1])
        }
        Layout.addLastForH(container, spacer: views[views.count-1], base: trailingView)
    }
    
    class func horizontalEvenSpaceCoverSpaces(#container:UIView ,leadingView:UIView,trailingView:UIView, views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0...views.count {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.regist(spacers[i], container: container)
                    .verticalCenterIsSame(views[0])
                    .height(10)
            } else {
                Layout.regist(spacers[i], container: container)
                    .verticalCenterIsSame(views[0])
                    .widthIsSame(spacers[0])
                    .height(10)
            }
        }
        
        Layout.addFirstForH(container, base: leadingView, first: spacers[0])
        for i in 0..<views.count {
            Layout.addNextSpaceForH(container, target: spacers[i], spacer: views[i])
            Layout.addNextSpaceForH(container, target: views[i], spacer: spacers[i+1])
        }
        Layout.addLastForH(container, spacer: spacers[views.count], base: trailingView)
    }

}



//verticalEvenSpace
extension Layout {
    
    
    private class func addFirstForV(container:UIView, base:UIView, first:UIView) {
        let l =  NSLayoutConstraint(item: base, attribute: .Top, relatedBy: .Equal, toItem: first, attribute: .Top, multiplier: 1.0, constant: 0)
        container.addConstraint(l)
    }
    
    private class func addNextSpaceForV(container:UIView, target:UIView, spacer:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .Top, relatedBy: .LessThanOrEqual, toItem: target, attribute: .Bottom, multiplier: 1.0, constant: 8)
        container.addConstraint(l)
    }
    
    private class func addLastForV(container:UIView, spacer:UIView, base:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .Bottom, relatedBy: .Equal, toItem: base, attribute: .Bottom, multiplier: 1.0, constant: 0)
        container.addConstraint(l)
    }
    
    
    class func verticalEvenSpaceInCotainer(#container:UIView ,views:[UIView],coverSpace:Bool) {
        if coverSpace {
            verticalEvenSpaceCoverSpaces(container: container, leadingView: container, trailingView: container, views: views)
        } else {
            verticalEvenSpaceNotCoverSpaces(container: container, leadingView: container, trailingView: container, views: views)
        }
    }
    
    class func verticalEvenSpaceNotCoverSpaces(#container:UIView ,leadingView:UIView, trailingView:UIView,views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0..<views.count-1 {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.regist(spacers[i], container: container)
                    .horizontalCenterIsSame(views[0])
                    .width(10)
            } else {
                Layout.regist(spacers[i], container: container)
                    .horizontalCenterIsSame(views[0])
                    .heightIsSame(spacers[0])
                    .width(10)
            }
            
            
        }
        
        Layout.addFirstForV(container, base: leadingView, first: views[0])
        for i in 0..<views.count-1 {
            Layout.addNextSpaceForV(container, target: views[i], spacer: spacers[i])
            Layout.addNextSpaceForV(container, target: spacers[i], spacer: views[i+1])
        }
        Layout.addLastForV(container, spacer: views[views.count-1], base: trailingView)
    }
    
    class func verticalEvenSpaceCoverSpaces(#container:UIView ,leadingView:UIView,trailingView:UIView, views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0...views.count {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.regist(spacers[i], container: container)
                    .horizontalCenterIsSame(views[0])
                    .width(10)
            } else {
                Layout.regist(spacers[i], container: container)
                    .horizontalCenterIsSame(views[0])
                    .heightIsSame(spacers[0])
                    .width(10)
            }
            
        }
        
        Layout.addFirstForV(container, base: leadingView, first: spacers[0])
        for i in 0..<views.count {
            Layout.addNextSpaceForV(container, target: spacers[i], spacer: views[i])
            Layout.addNextSpaceForV(container, target: views[i], spacer: spacers[i+1])
        }
        Layout.addLastForV(container, spacer: spacers[views.count], base: trailingView)
    }
    
}

//text系
extension Layout {
    
    func fitWidthFromText() -> Layout {
        if self.target is UILabel {
            let ui = self.target as UILabel
            ui.sizeToFit()
            self.width(ui.frame.size.width)
        }
        return self
    }
    
    func textAlignmentIsLeft() -> Layout {
        if self.target is UILabel {
            let ui = self.target as UILabel
            ui.textAlignment = .Left
        }
        return self
    }
    
    func textAlignmentIsCenter() -> Layout {
        if self.target is UILabel {
            let ui = self.target as UILabel
            ui.textAlignment = .Center
        }
        return self
    }
    
    func textAlignmentIsRight() -> Layout {
        if self.target is UILabel {
            let ui = self.target as UILabel
            ui.textAlignment = .Right
        }
        return self
    }
    
}

//UIView生成
extension Layout {
    
    class func createSystemTypeBtn(title:String) -> UIButton {
        let btn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        btn.setTitle(title, forState:.Normal)
        return btn
    }
    
    class func createWordWrappingLabel(text:String) -> UILabel {
        var lbl = UILabel()
        lbl.text = text
        lbl.numberOfLines  = 0;
        lbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return lbl
    }
    
    class func createCharWrappingLabel(text:String) -> UILabel {
        var lbl = UILabel()
        lbl.text = text
        lbl.numberOfLines  = 0;
        lbl.lineBreakMode = NSLineBreakMode.ByCharWrapping
        return lbl
    }
    
}

//touchイベントの登録にブロックを渡せるようにする
//Layoutとは特に関係ない
class TouchBlocks {
    var touchBlockList:[TouchBlock] = []
    
    func append(owner:UIControl,  block: () -> Void) {
        self.touchBlockList.append(
            TouchBlock(owner:owner, block:block)
        )
    }
}


class TouchBlock:NSObject {
    
    private let _block:() -> Void
    
    init(owner:UIControl,  block: () -> Void){
        self._block = block
        
        super.init()
        
        owner.addTarget(self, action: "doAction", forControlEvents: .TouchUpInside)
    }
    
    func doAction(){
        _block()
    }
}