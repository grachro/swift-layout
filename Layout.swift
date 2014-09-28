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
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .Top, relatedBy: .Equal, toItem: base, attribute: .Top, multiplier: 1.0, constant: self._size)
        self._layout.addLayoutConstraint(l)
        self._layout._topConstraint = l
        return self._layout
    }
    
    func fromSuperviewTop() -> Layout{
        return fromTop(self._layout.superview)
    }
    
    func fromBottom(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .Top, relatedBy: .Equal, toItem: base, attribute: .Bottom, multiplier: 1.0, constant: self._size)
        self._layout.addLayoutConstraint(l)
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
    
    func fromTop(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .Bottom, relatedBy: .Equal, toItem: base, attribute: .Top, multiplier: 1.0, constant: -self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    func fromBottom(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .Bottom, relatedBy: .Equal, toItem: base, attribute: .Bottom, multiplier: 1.0, constant: -self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    func fromSuperviewBottom() -> Layout{
        return fromBottom(self._layout.superview)
    }
    
}


class LayoutLeft {
    private let _layout:Layout
    private let _size:CGFloat
    
    private init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    
    func fromLeft(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .Left, relatedBy: .Equal, toItem: base, attribute: .Left, multiplier: 1.0, constant: self._size)
        self._layout.addLayoutConstraint(l)
        self._layout._leftConstraint = l
        return self._layout
    }
    
    func fromRight(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .Left, relatedBy: .Equal, toItem: base, attribute: .Right, multiplier: 1.0, constant: self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    func fromSuperviewLeft() -> Layout {
        return fromLeft(self._layout.superview)
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
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .Right, relatedBy: .Equal, toItem: base, attribute: .Left, multiplier: 1.0, constant: -self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    func fromRight(base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .Right, relatedBy: .Equal, toItem: base, attribute: .Right, multiplier: 1.0, constant: -self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    func fromSuperviewRight() -> Layout{
        return fromRight(self._layout.superview)
    }
}


class Layout {
    
    class func more(view:UIView) -> Layout {
        return Layout(view: view, superview: view.superview!)
    }

    class func regist(view:UIView, superview:UIView) -> Layout {
        let layout = Layout(view: view, superview: superview)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        superview.addSubview(view)
        return layout
    }
    
    class func registUIView(#superview:UIView) -> Layout {
        return regist(UIView(), superview:superview)
    }
    
    class func registUILabel(#superview:UIView) -> Layout {
        return regist(UILabel(), superview:superview)
    }
    
    class func registUITextField(#superview:UIView) -> Layout {
        return regist(UITextField(), superview:superview)
    }
    
    class func registSystemTypeBtn(title:String, superview:UIView) -> Layout {
        return regist(Layout.createSystemTypeBtn(title), superview:superview)
    }

    
    private let _target:UIView
    private var superview:UIView
    private var _lastConstraint:NSLayoutConstraint? = nil
    private var _leftConstraint:NSLayoutConstraint? = nil
    private var _topConstraint:NSLayoutConstraint? = nil
    private var _allConstraint:[NSLayoutConstraint]? = nil
    
    var target:UIView {get{return _target}}
    var view:UIView {get{return _target}}
    
    private init(view:UIView, superview:UIView) {
        self._target = view
        self.superview = superview
    }
    
   
    func changeSuperview(#newSuperview:UIView) -> Layout {
        
        //remove from old supservire
        if self._allConstraint != nil {
            for c in self._allConstraint! {
                newSuperview.removeConstraint(c)
            }
        }
        self._target.removeFromSuperview()
        
        //change
        self.superview = newSuperview
        newSuperview.addSubview(self._target)
  
        return self
    }

    
 
    
    func lastConstraint(inout constraint:NSLayoutConstraint?) -> Layout {
        constraint = self._lastConstraint
        return self
        
    }
    
    private func addLayoutConstraint(constraint:NSLayoutConstraint) {
        self._lastConstraint = constraint
        self.superview.addConstraint(constraint)
        
        if self._allConstraint == nil {
            self._allConstraint = []
        }
        self._allConstraint!.append(constraint)
    }
    
    func top(size:CGFloat) -> LayoutTop {
        return LayoutTop(layout: self, size: size)
    }
    
    func topIsSame(base:UIView) -> Layout {
        return LayoutTop(layout: self, size: 0).fromTop(base)
    }
    
    func topIsSameSuperview() -> Layout {
        return topIsSame(self.superview)
    }
    
    func bottom(size:CGFloat) -> LayoutBottom {
        return LayoutBottom(layout: self, size: size)
    }
    
    func bottomIsSame(base:UIView) -> Layout {
        return LayoutBottom(layout: self, size: 0).fromBottom(base)
    }
    
    func bottomIsSameSuperview() -> Layout {
        return bottomIsSame(self.superview)
    }
    
    func left(size:CGFloat) -> LayoutLeft {
        return LayoutLeft(layout: self, size: size)
    }
    
    func leftIsSame(base:UIView) -> Layout {
        return LayoutLeft(layout: self, size: 0).fromLeft(base)
    }
    
    func leftIsSameSuperview() -> Layout {
        return leftIsSame(self.superview)
    }

    func right(size:CGFloat) -> LayoutRight {
        return LayoutRight(layout: self, size: size)
    }
    
    func rightIsSame(base:UIView) -> Layout {
        return LayoutRight(layout: self, size: 0).fromRight(base)
    }
    
    func rightIsSameSuperview() -> Layout {
        return rightIsSame(self.superview)
    }
    
    func coverSuperView() -> Layout {
        rightIsSameSuperview()
        leftIsSameSuperview()
        topIsSameSuperview()
        bottomIsSameSuperview()
        return self
    }
    
    func width(size:CGFloat) -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size)
        self.addLayoutConstraint(l)
        return self
    }
    
    func widthIsSame(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .Width, relatedBy: .Equal, toItem: base, attribute: .Width, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    func height(size:CGFloat) -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size)
        self.addLayoutConstraint(l)
        return self
    }
    
    func heightIsSame(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .Height, relatedBy: .Equal, toItem: base, attribute: .Height, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    func horizontalCenterIsSame(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: base, attribute: .CenterX, relatedBy: .Equal, toItem: self._target, attribute: .CenterX, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    func verticalCenterIsSame(base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: base, attribute: .CenterY, relatedBy: .Equal, toItem: self._target, attribute: .CenterY, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    
    func horizontalCenterInSuperview() -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .CenterX, relatedBy: .Equal, toItem: self.superview, attribute: .CenterX, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    func verticalCenterInSuperview() -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .CenterY, relatedBy: .Equal, toItem: self.superview, attribute: .CenterY, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
}


//change constant
extension Layout {

    func toLeft(size:CGFloat) -> Layout {
        self._leftConstraint?.constant = size
        return self
    }
    
    func toTop(size:CGFloat) -> Layout {
        self._topConstraint?.constant = size
        return self
    }
    
    
}


//screen positon
extension Layout {
 
    func viewController() -> UIViewController? {
        return viewController(self._target.nextResponder())
    }
    
    private func viewController(responder:UIResponder?) -> UIViewController? {
        if responder == nil {
            return nil
        } else if responder is UIViewController {
            return responder as UIViewController!
        }
        
        return viewController(responder!.nextResponder())
    }
 
    func rootView() -> UIView {
        return Layout.rootView(self._target)
    }
    
    class func rootView(view:UIView) -> UIView {
        if view.superview == nil {
            return view
        } else {
            return rootView(view.superview!)
        }
    }

    func displayRect() -> CGRect {
        rootView().layoutIfNeeded()
        return self._target.convertRect(self._target.bounds, toView: Layout.rootView(self._target))
    }
    
    func anotherViewRect(anotherView:UIView) -> CGRect {
       return anotherView.convertRect(anotherView.bounds, toView: self._target)
    }
}


//horizontalEvenSpace
extension Layout {
    
    
    private class func addFirstForH(superview:UIView, base:UIView, first:UIView) {
        let l =  NSLayoutConstraint(item: base, attribute: .Leading, relatedBy: .Equal, toItem: first, attribute: .Leading, multiplier: 1.0, constant: 0)
        superview.addConstraint(l)
    }
    
    private class func addNextSpaceForH(superview:UIView, target:UIView, spacer:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .Leading, relatedBy: .LessThanOrEqual, toItem: target, attribute: .Trailing, multiplier: 1.0, constant: 8)
        superview.addConstraint(l)
    }
    
    private class func addLastForH(superview:UIView, spacer:UIView, base:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .Trailing, relatedBy: .Equal, toItem: base, attribute: .Trailing, multiplier: 1.0, constant: 0)
        superview.addConstraint(l)
    }
    
    
    class func horizontalEvenSpaceInCotainer(#superview:UIView ,layouts:[Layout],coverSpace:Bool) {
        var tmpView:[UIView] = []
        layouts.map({tmpView.append($0.target)})
        horizontalEvenSpaceInCotainer(superview:superview ,views:tmpView,coverSpace:coverSpace)
    }
    
    class func horizontalEvenSpaceInCotainer(#superview:UIView ,views:[UIView],coverSpace:Bool) {
        if coverSpace {
            horizontalEvenSpaceCoverSpaces(superview: superview, leadingView: superview, trailingView: superview, views: views)
        } else {
            horizontalEvenSpaceNotCoverSpaces(superview: superview, leadingView: superview, trailingView: superview, views: views)
        }
    }
    
    class func horizontalEvenSpaceNotCoverSpaces(#superview:UIView ,leadingView:UIView, trailingView:UIView,views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0..<views.count-1 {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.regist(spacers[i], superview: superview)
                    .verticalCenterIsSame(views[0])
                    .height(10)
            } else {
                Layout.regist(spacers[i], superview: superview)
                    .verticalCenterIsSame(views[0])
                    .widthIsSame(spacers[0])
                    .height(10)
            }
        }
        
        Layout.addFirstForH(superview, base: leadingView, first: views[0])
        for i in 0..<views.count-1 {
            Layout.addNextSpaceForH(superview, target: views[i], spacer: spacers[i])
            Layout.addNextSpaceForH(superview, target: spacers[i], spacer: views[i+1])
        }
        Layout.addLastForH(superview, spacer: views[views.count-1], base: trailingView)
    }
    
    class func horizontalEvenSpaceCoverSpaces(#superview:UIView ,leadingView:UIView,trailingView:UIView, views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0...views.count {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.regist(spacers[i], superview: superview)
                    .verticalCenterIsSame(views[0])
                    .height(10)
            } else {
                Layout.regist(spacers[i], superview: superview)
                    .verticalCenterIsSame(views[0])
                    .widthIsSame(spacers[0])
                    .height(10)
            }
        }
        
        Layout.addFirstForH(superview, base: leadingView, first: spacers[0])
        for i in 0..<views.count {
            Layout.addNextSpaceForH(superview, target: spacers[i], spacer: views[i])
            Layout.addNextSpaceForH(superview, target: views[i], spacer: spacers[i+1])
        }
        Layout.addLastForH(superview, spacer: spacers[views.count], base: trailingView)
    }
    
}



//verticalEvenSpace
extension Layout {
    
    
    private class func addFirstForV(superview:UIView, base:UIView, first:UIView) {
        let l =  NSLayoutConstraint(item: base, attribute: .Top, relatedBy: .Equal, toItem: first, attribute: .Top, multiplier: 1.0, constant: 0)
        superview.addConstraint(l)
    }
    
    private class func addNextSpaceForV(superview:UIView, target:UIView, spacer:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .Top, relatedBy: .LessThanOrEqual, toItem: target, attribute: .Bottom, multiplier: 1.0, constant: 8)
        superview.addConstraint(l)
    }
    
    private class func addLastForV(superview:UIView, spacer:UIView, base:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .Bottom, relatedBy: .Equal, toItem: base, attribute: .Bottom, multiplier: 1.0, constant: 0)
        superview.addConstraint(l)
    }
    
    
    class func verticalEvenSpaceInCotainer(#superview:UIView ,views:[UIView],coverSpace:Bool) {
        if coverSpace {
            verticalEvenSpaceCoverSpaces(superview: superview, leadingView: superview, trailingView: superview, views: views)
        } else {
            verticalEvenSpaceNotCoverSpaces(superview: superview, leadingView: superview, trailingView: superview, views: views)
        }
    }
    
    class func verticalEvenSpaceNotCoverSpaces(#superview:UIView ,leadingView:UIView, trailingView:UIView,views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0..<views.count-1 {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.regist(spacers[i], superview: superview)
                    .horizontalCenterIsSame(views[0])
                    .width(10)
            } else {
                Layout.regist(spacers[i], superview: superview)
                    .horizontalCenterIsSame(views[0])
                    .heightIsSame(spacers[0])
                    .width(10)
            }
            
            
        }
        
        Layout.addFirstForV(superview, base: leadingView, first: views[0])
        for i in 0..<views.count-1 {
            Layout.addNextSpaceForV(superview, target: views[i], spacer: spacers[i])
            Layout.addNextSpaceForV(superview, target: spacers[i], spacer: views[i+1])
        }
        Layout.addLastForV(superview, spacer: views[views.count-1], base: trailingView)
    }
    
    class func verticalEvenSpaceCoverSpaces(#superview:UIView ,leadingView:UIView,trailingView:UIView, views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0...views.count {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.regist(spacers[i], superview: superview)
                    .horizontalCenterIsSame(views[0])
                    .width(10)
            } else {
                Layout.regist(spacers[i], superview: superview)
                    .horizontalCenterIsSame(views[0])
                    .heightIsSame(spacers[0])
                    .width(10)
            }
            
        }
        
        Layout.addFirstForV(superview, base: leadingView, first: spacers[0])
        for i in 0..<views.count {
            Layout.addNextSpaceForV(superview, target: spacers[i], spacer: views[i])
            Layout.addNextSpaceForV(superview, target: views[i], spacer: spacers[i+1])
        }
        Layout.addLastForV(superview, spacer: spacers[views.count], base: trailingView)
    }
    
}

//UIView全般
extension Layout {
    func backgroundColor(color:UIColor) -> Layout {
        self._target.backgroundColor = color
        return self
    }
    
    func backgroundColorAlpha(alpha:CGFloat) -> Layout {
        self._target.backgroundColor = self._target.backgroundColor?.colorWithAlphaComponent(alpha)
        return self
    }
    
    func hide() -> Layout {
        self._target.hidden =  true
        return self
    }
    
    func show() -> Layout {
        self._target.hidden =  false
        return self
    }
    
    func hidden(val:Bool) -> Layout {
        self._target.hidden =  val
        return self
    }

    func toggle(val:Bool) -> Layout {
        self._target.hidden =  !self._target.hidden
        return self
    }
    
    func zPosition(val:CGFloat) -> Layout {
        self._target.layer.zPosition = val
        return self
    }
    
}

//text,label系
extension Layout {
    
    func text(text:String) -> Layout {
        if self._target is UILabel {
            (self._target as UILabel).text = text
        } else if self._target is UITextField {
            (self._target as UITextField).text = text
        }
        return self
    }
    
    func fitWidthFromText() -> Layout {
        
        if self._target is UILabel {
            let ui = self._target as UILabel
            ui.sizeToFit()
            self.width(ui.frame.size.width)
            
        }
        
        return self
    }
    
    func textAlignmentIsLeft() -> Layout {
        if self._target is UILabel {
            (self._target as UILabel).textAlignment = .Left
        } else if self._target is UITextField {
            (self._target as UITextField).textAlignment = .Left
        }
        return self
    }
    
    func textAlignmentIsCenter() -> Layout {
        if self._target is UILabel {
            (self._target as UILabel).textAlignment = .Center
        } else if self._target is UITextField {
            (self._target as UITextField).textAlignment = .Center
        }
        return self
    }
    
    func textAlignmentIsRight() -> Layout {
        if self._target is UILabel {
            (self._target as UILabel).textAlignment = .Right
        } else if self._target is UITextField {
            (self._target as UITextField).textAlignment = .Right
        }
        return self
    }
    
    func font(font:UIFont) -> Layout {
        if self._target is UILabel {
            (self._target as UILabel).font = font
        } else if self._target is UITextField {
            (self._target as UITextField).font = font
        }
        return self
    }
    
    func systemFont(size:CGFloat) -> Layout {
        self.font(UIFont.systemFontOfSize(size))
        return self
    }
    
    func boldSystemFont(size:CGFloat) -> Layout {
        self.font(UIFont.boldSystemFontOfSize(size))
        return self
    }
    
    func textColor(color:UIColor) -> Layout {
        if self._target is UILabel {
            (self._target as UILabel).textColor = color
        } else if self._target is UITextField {
            (self._target as UITextField).textColor = color
        } else if self._target is UIButton {
            (self._target as UIButton).setTitleColor(color, forState: .Normal)
        }
        return self
    }
    
    
}

//text系
extension Layout {
    func textFieldBorderStyle(style:UITextBorderStyle) -> Layout {
        if self._target is UITextField {
            (self._target as UITextField).borderStyle = style
        }
        return self
    }
    
    func keyboardType(type:UIKeyboardType) -> Layout {
        if self._target is UITextField {
            (self._target as UITextField).keyboardType = type
        }
        return self
    }
}

//イベント系
extension Layout {
    func touchUpInside(block:() -> Void) -> Layout {
        if self._target is UIControl {
            TouchBlocks.append((self._target as UIControl), block: block)
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

    class func createExtraLightBlurEffect() -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
    }
    
    class func createLightBlurEffect() -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .Light))
    }

    class func createDarkBlurEffect() -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
    }

}

extension Layout {
    class func roundRect(view:UIView, byRoundingCorners corners: UIRectCorner,cornerRadii:CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSizeMake(cornerRadii, cornerRadii)
        )
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.bounds
        shapeLayer.path = path.CGPath
        view.layer.mask = shapeLayer
    }
    
    func roundRect(byRoundingCorners corners: UIRectCorner,cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: corners, cornerRadii:cornerRadii)
        return self
    }
    
    func roundRectTop(cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: (UIRectCorner.TopLeft | UIRectCorner.TopRight), cornerRadii:cornerRadii)
        return self
    }
    
    func roundRectLeft(cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: (UIRectCorner.TopLeft | UIRectCorner.BottomLeft), cornerRadii:cornerRadii)
        return self
    }
    
    func roundRectRight(cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: (UIRectCorner.TopRight | UIRectCorner.BottomRight), cornerRadii:cornerRadii)
        return self
    }
    
    func roundRectBottom(cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: (UIRectCorner.BottomLeft | UIRectCorner.BottomRight), cornerRadii:cornerRadii)
        return self
    }
}

//touchイベントの登録にブロックを渡せるようにする
private var touchBlockStaticList:[TouchBlock] = []
class TouchBlocks {
    class func append(owner:UIControl,  block: () -> Void) {
        touchBlockStaticList.append(
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