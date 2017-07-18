//
//  Layout.swift
//  swift-layout
//
//  Created by grachro on 2014/09/06.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit


class LayoutTop {
    fileprivate let _layout:Layout
    fileprivate let _size:CGFloat
    
    fileprivate init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    @discardableResult
    func fromTop(_ base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .top, relatedBy: .equal, toItem: base, attribute: .top, multiplier: 1.0, constant: self._size)
        self._layout.addLayoutConstraint(l)
        self._layout._topConstraint = l
        return self._layout
    }
    
    @discardableResult
    func fromSuperviewTop() -> Layout{
        return fromTop(self._layout.superview)
    }
    
    @discardableResult
    func fromBottom(_ base:UIView) -> Layout{
        return fromBottomAny(base)
    }
    
    @discardableResult
    func fromBottom(_ base:UILayoutSupport) -> Layout{
        return fromBottomAny(base)
    }
    
    @discardableResult
    fileprivate func fromBottomAny(_ base:AnyObject) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .top, relatedBy: .equal, toItem: base, attribute: .bottom, multiplier: 1.0, constant: self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
}


class LayoutBottom {
    fileprivate let _layout:Layout
    fileprivate let _size:CGFloat
    
    fileprivate init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    @discardableResult
    func fromTop(_ base:UIView) -> Layout {
        return fromTopAny(base)
    }
    
    @discardableResult
    func fromTop(_ base:UILayoutSupport) -> Layout {
        return fromTopAny(base)
    }
    
    fileprivate func fromTopAny(_ base:AnyObject) -> Layout {
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .bottom, relatedBy: .equal, toItem: base, attribute: .top, multiplier: 1.0, constant: -self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    @discardableResult
    func fromBottom(_ base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .bottom, relatedBy: .equal, toItem: base, attribute: .bottom, multiplier: 1.0, constant: -self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    @discardableResult
    func fromSuperviewBottom() -> Layout{
        return fromBottom(self._layout.superview)
    }
    
}


class LayoutLeft {
    fileprivate let _layout:Layout
    fileprivate let _size:CGFloat
    
    fileprivate init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    
    @discardableResult
    func fromLeft(_ base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .left, relatedBy: .equal, toItem: base, attribute: .left, multiplier: 1.0, constant: self._size)
        self._layout.addLayoutConstraint(l)
        self._layout._leftConstraint = l
        return self._layout
    }
    
    @discardableResult
    func fromRight(_ base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .left, relatedBy: .equal, toItem: base, attribute: .right, multiplier: 1.0, constant: self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    @discardableResult
    func fromSuperviewLeft() -> Layout {
        return fromLeft(self._layout.superview)
    }
}

class LayoutRight {
    fileprivate let _layout:Layout
    fileprivate let _size:CGFloat
    
    fileprivate init (layout:Layout, size:CGFloat) {
        self._layout = layout
        self._size = size
    }
    
    @discardableResult
    func fromLeft(_ base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .right, relatedBy: .equal, toItem: base, attribute: .left, multiplier: 1.0, constant: -self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    @discardableResult
    func fromRight(_ base:UIView) -> Layout{
        let l =  NSLayoutConstraint(item: self._layout._target, attribute: .right, relatedBy: .equal, toItem: base, attribute: .right, multiplier: 1.0, constant: -self._size)
        self._layout.addLayoutConstraint(l)
        return self._layout
    }
    
    @discardableResult
    func fromSuperviewRight() -> Layout{
        return fromRight(self._layout.superview)
    }
}


class Layout {
    
    @discardableResult
    class func more(_ view:UIView) -> Layout {
        return Layout(view: view, superview: view.superview!)
    }

    @discardableResult
    class func addSubView(_ view:UIView, superview:UIView) -> Layout {
        let layout = Layout(view: view, superview: superview)
        view.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(view)
        return layout
    }
    
    @discardableResult
    class func addUIView(superview:UIView) -> Layout {
        return addSubView(UIView(), superview:superview)
    }
    
    @discardableResult
    class func addUILabel(superview:UIView) -> Layout {
        return addSubView(UILabel(), superview:superview)
    }
    
    @discardableResult
    class func addUITextField(superview:UIView) -> Layout {
        return addSubView(UITextField(), superview:superview)
    }
    
    @discardableResult
    class func addSystemTypeBtn(_ title:String, superview:UIView) -> Layout {
        return addSubView(Layout.createSystemTypeBtn(title), superview:superview)
    }

    
    weak fileprivate var _target:UIView!
    weak fileprivate var superview:UIView!
    fileprivate var _lastConstraint:NSLayoutConstraint? = nil
    fileprivate var _leftConstraint:NSLayoutConstraint? = nil
    fileprivate var _topConstraint:NSLayoutConstraint? = nil
    fileprivate var _allConstraint:[NSLayoutConstraint]? = nil
    
    var target:UIView {get{return _target}}
    var view:UIView {get{return _target}}
    
    fileprivate init(view:UIView, superview:UIView) {
        self._target = view
        self.superview = superview
    }
    
   
    @discardableResult
    func changeSuperview(newSuperview:UIView) -> Layout {
        
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


    @discardableResult
    func lastConstraint(_ constraint:inout NSLayoutConstraint?) -> Layout {
        constraint = self._lastConstraint
        return self
        
    }
    
    @discardableResult
    func lastConstraintPriority(_ priority:Int) -> Layout {
        _ = self._lastConstraint?.priority
        return self
    }

    fileprivate func addLayoutConstraint(_ constraint:NSLayoutConstraint, constraintOwner:UIView?=nil) {
        self._lastConstraint = constraint
        
        if let owner = constraintOwner as UIView! {
            owner.addConstraint(constraint)
        } else {
            self.superview.addConstraint(constraint)
        }
        
        if self._allConstraint == nil {
            self._allConstraint = []
        }
        self._allConstraint!.append(constraint)
    }
    
    func top(_ size:CGFloat) -> LayoutTop {
        return LayoutTop(layout: self, size: size)
    }
    
    @discardableResult
    func topIsSame(_ base:UIView) -> Layout {
        return LayoutTop(layout: self, size: 0).fromTop(base)
    }
    
    @discardableResult
    func topIsSameSuperview() -> Layout {
        return topIsSame(self.superview)
    }
    
    func bottom(_ size:CGFloat) -> LayoutBottom {
        return LayoutBottom(layout: self, size: size)
    }
    
    @discardableResult
    func bottomIsSame(_ base:UIView) -> Layout {
        return LayoutBottom(layout: self, size: 0).fromBottom(base)
    }
    
    @discardableResult
    func bottomIsSameSuperview() -> Layout {
        return bottomIsSame(self.superview)
    }
    
    func left(_ size:CGFloat) -> LayoutLeft {
        return LayoutLeft(layout: self, size: size)
    }
    
    @discardableResult
    func leftIsSame(_ base:UIView) -> Layout {
        return LayoutLeft(layout: self, size: 0).fromLeft(base)
    }
    
    @discardableResult
    func leftIsSameSuperview() -> Layout {
        return leftIsSame(self.superview)
    }

    func right(_ size:CGFloat) -> LayoutRight {
        return LayoutRight(layout: self, size: size)
    }
    
    @discardableResult
    func rightIsSame(_ base:UIView) -> Layout {
        return LayoutRight(layout: self, size: 0).fromRight(base)
    }
    
    @discardableResult
    func rightIsSameSuperview() -> Layout {
        return rightIsSame(self.superview)
    }
    
    @discardableResult
    func coverSuperView() -> Layout {
        rightIsSameSuperview()
        leftIsSameSuperview()
        topIsSameSuperview()
        bottomIsSameSuperview()
        return self
    }
    
    @discardableResult
    func width(_ size:CGFloat) -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size)
        self.addLayoutConstraint(l)
        return self
    }
    
    @discardableResult
    func widthIsSame(_ base:UIView, constraintOwner:UIView? = nil) -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .width, relatedBy: .equal, toItem: base, attribute: .width, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l, constraintOwner:constraintOwner)
        return self
    }
    
    @discardableResult
    func widthIsSameSuperview() -> Layout {
        return widthIsSame(self.superview)
    }

    @discardableResult
    func height(_ size:CGFloat) -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size)
        self.addLayoutConstraint(l)
        return self
    }
    
    @discardableResult
    func heightIsSame(_ base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .height, relatedBy: .equal, toItem: base, attribute: .height, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    //TODO test
    @discardableResult
    func heightIsSameSuperview() -> Layout {
        return heightIsSame(self.superview)
    }

    @discardableResult
    func horizontalCenterIsSame(_ base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: base, attribute: .centerX, relatedBy: .equal, toItem: self._target, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    @discardableResult
    func verticalCenterIsSame(_ base:UIView) -> Layout {
        let l =  NSLayoutConstraint(item: base, attribute: .centerY, relatedBy: .equal, toItem: self._target, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    
    @discardableResult
    func horizontalCenterInSuperview() -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .centerX, relatedBy: .equal, toItem: self.superview, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
    
    @discardableResult
    func verticalCenterInSuperview() -> Layout {
        let l =  NSLayoutConstraint(item: self._target, attribute: .centerY, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.addLayoutConstraint(l)
        return self
    }
}


//change constant
extension Layout {

    @discardableResult
    func toLeft(_ size:CGFloat) -> Layout {
        self._leftConstraint?.constant = size
        return self
    }
    
    @discardableResult
    func toTop(_ size:CGFloat) -> Layout {
        self._topConstraint?.constant = size
        return self
    }
    
    
}


//screen positon
extension Layout {
 
    func viewController() -> UIViewController? {
        return viewController(self._target.next)
    }
    
    fileprivate func viewController(_ responder:UIResponder?) -> UIViewController? {
        
        if responder == nil {
            return nil
        } else if let viewCon = responder as? UIViewController {
            return viewCon
        }
        
        return viewController(responder!.next)
    }
 
    func rootView() -> UIView {
        return Layout.rootView(self._target)
    }
    
    class func rootView(_ view:UIView) -> UIView {
        if view.superview == nil {
            return view
        } else {
            return rootView(view.superview!)
        }
    }

    func displayRect() -> CGRect {
        rootView().layoutIfNeeded()
        return self._target.convert(self._target.bounds, to: Layout.rootView(self._target))
    }
    
    func anotherViewRect(_ anotherView:UIView) -> CGRect {
       return anotherView.convert(anotherView.bounds, to: self._target)
    }
}


//horizontalEvenSpace
extension Layout {
    
    
    fileprivate class func addFirstForH(_ superview:UIView, base:UIView, first:UIView) {
        let l =  NSLayoutConstraint(item: base, attribute: .leading, relatedBy: .equal, toItem: first, attribute: .leading, multiplier: 1.0, constant: 0)
        superview.addConstraint(l)
    }
    
    fileprivate class func addNextSpaceForH(_ superview:UIView, target:UIView, spacer:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .leading, relatedBy: .lessThanOrEqual, toItem: target, attribute: .trailing, multiplier: 1.0, constant: 8)
        superview.addConstraint(l)
    }
    
    fileprivate class func addLastForH(_ superview:UIView, spacer:UIView, base:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .trailing, relatedBy: .equal, toItem: base, attribute: .trailing, multiplier: 1.0, constant: 0)
        superview.addConstraint(l)
    }
    
    
    class func horizontalEvenSpaceInCotainer(superview:UIView ,layouts:[Layout],coverSpace:Bool) {
        var tmpView:[UIView] = []
        _ = layouts.map({tmpView.append($0.target)})
        horizontalEvenSpaceInCotainer(superview:superview ,views:tmpView,coverSpace:coverSpace)
    }
    
    class func horizontalEvenSpaceInCotainer(superview:UIView ,views:[UIView],coverSpace:Bool) {
        if coverSpace {
            horizontalEvenSpaceCoverSpaces(superview: superview, leadingView: superview, trailingView: superview, views: views)
        } else {
            horizontalEvenSpaceNotCoverSpaces(superview: superview, leadingView: superview, trailingView: superview, views: views)
        }
    }
    
    class func horizontalEvenSpaceNotCoverSpaces(superview:UIView ,leadingView:UIView, trailingView:UIView,views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0..<views.count-1 {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.addSubView(spacers[i], superview: superview)
                    .verticalCenterIsSame(views[0])
                    .height(10)
            } else {
                Layout.addSubView(spacers[i], superview: superview)
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
    
    class func horizontalEvenSpaceCoverSpaces(superview:UIView ,leadingView:UIView,trailingView:UIView, views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0...views.count {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.addSubView(spacers[i], superview: superview)
                    .verticalCenterIsSame(views[0])
                    .height(10)
            } else {
                Layout.addSubView(spacers[i], superview: superview)
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
    
    
    fileprivate class func addFirstForV(_ superview:UIView, base:UIView, first:UIView) {
        let l =  NSLayoutConstraint(item: base, attribute: .top, relatedBy: .equal, toItem: first, attribute: .top, multiplier: 1.0, constant: 0)
        superview.addConstraint(l)
    }
    
    fileprivate class func addNextSpaceForV(_ superview:UIView, target:UIView, spacer:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .top, relatedBy: .lessThanOrEqual, toItem: target, attribute: .bottom, multiplier: 1.0, constant: 8)
        superview.addConstraint(l)
    }
    
    fileprivate class func addLastForV(_ superview:UIView, spacer:UIView, base:UIView) {
        let l =  NSLayoutConstraint(item: spacer, attribute: .bottom, relatedBy: .equal, toItem: base, attribute: .bottom, multiplier: 1.0, constant: 0)
        superview.addConstraint(l)
    }
    
    
    class func verticalEvenSpaceInCotainer(superview:UIView ,views:[UIView],coverSpace:Bool) {
        if coverSpace {
            verticalEvenSpaceCoverSpaces(superview: superview, leadingView: superview, trailingView: superview, views: views)
        } else {
            verticalEvenSpaceNotCoverSpaces(superview: superview, leadingView: superview, trailingView: superview, views: views)
        }
    }
    
    class func verticalEvenSpaceNotCoverSpaces(superview:UIView ,leadingView:UIView, trailingView:UIView,views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0..<views.count-1 {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.addSubView(spacers[i], superview: superview)
                    .horizontalCenterIsSame(views[0])
                    .width(10)
            } else {
                Layout.addSubView(spacers[i], superview: superview)
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
    
    class func verticalEvenSpaceCoverSpaces(superview:UIView ,leadingView:UIView,trailingView:UIView, views:[UIView]) {
        var spacers:[UIView] = []
        for i in 0...views.count {
            let spacer = UIView()
            spacers.append(spacer)
            
            if i == 0 {
                Layout.addSubView(spacers[i], superview: superview)
                    .horizontalCenterIsSame(views[0])
                    .width(10)
            } else {
                Layout.addSubView(spacers[i], superview: superview)
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
    @discardableResult
    func backgroundColor(_ color:UIColor) -> Layout {
        self._target.backgroundColor = color
        return self
    }
    
    @discardableResult
    func backgroundColorAlpha(_ alpha:CGFloat) -> Layout {
        self._target.backgroundColor = self._target.backgroundColor?.withAlphaComponent(alpha)
        return self
    }
    
    @discardableResult
    func hide() -> Layout {
        self._target.isHidden =  true
        return self
    }
    
    @discardableResult
    func show() -> Layout {
        self._target.isHidden =  false
        return self
    }
    
    @discardableResult
    func hidden(_ val:Bool) -> Layout {
        self._target.isHidden =  val
        return self
    }

    @discardableResult
    func toggle(_ val:Bool) -> Layout {
        self._target.isHidden =  !self._target.isHidden
        return self
    }
    
    @discardableResult
    func zPosition(_ val:CGFloat) -> Layout {
        self._target.layer.zPosition = val
        return self
    }
    
}

//text,label系
extension Layout {
    
    @discardableResult
    func text(_ text:String) -> Layout {
        
        if let l = self._target as? UILabel {
            l.text = text
        } else if let t = self._target as? UITextField {
            t.text = text
        }

        return self
    }

    @discardableResult
    func sizeToFit() -> Layout {
        
        if let ui = self._target as? UILabel {
            ui.sizeToFit()
        }
        
        return self
    }

    @discardableResult
    func fitWidthFromText() -> Layout {
        
        if let ui = self._target as? UILabel {
            ui.sizeToFit()
            self.width(ui.frame.size.width)
            
        }
        
        return self
    }
    
    @discardableResult
    func textAlignmentIsLeft() -> Layout {
        if let l = self._target as? UILabel {
            l.textAlignment = .left
        } else if let t = self._target as? UITextField {
            t.textAlignment = .left
        }
        return self
    }
    
    @discardableResult
    func textAlignmentIsCenter() -> Layout {
        if let l = self._target as? UILabel {
            l.textAlignment = .center
        } else if let t = self._target as? UITextField {
            t.textAlignment = .center
        }
        return self
    }
    
    @discardableResult
    func textAlignmentIsRight() -> Layout {
        if let l = self._target as? UILabel {
            l.textAlignment = .right
        } else if let t = self._target as? UITextField {
            t.textAlignment = .right
        }
        return self
    }
    
    @discardableResult
    func font(_ font:UIFont) -> Layout {
        if let l = self._target as? UILabel {
            l.font = font
        } else if let t = self._target as? UITextField {
            t.font = font
        }
        return self
    }
    
    @discardableResult
    func systemFont(_ size:CGFloat) -> Layout {
        self.font(UIFont.systemFont(ofSize: size))
        return self
    }
    
    @discardableResult
    func boldSystemFont(_ size:CGFloat) -> Layout {
        self.font(UIFont.boldSystemFont(ofSize: size))
        return self
    }
    
    @discardableResult
    func textColor(_ color:UIColor) -> Layout {
        if let l = self._target as? UILabel {
            l.textColor = color
        } else if let t = self._target as? UITextField {
            t.textColor = color
        } else if let b = self._target as? UIButton {
            b.setTitleColor(color, for: UIControlState())
        }
        return self
    }
    
    
}

//text系
extension Layout {
    
    @discardableResult
    func textFieldBorderStyle(_ style:UITextBorderStyle) -> Layout {
        if let t = self._target as? UITextField {
            t.borderStyle = style
        }
        return self
    }
    
    @discardableResult
    func keyboardType(_ type:UIKeyboardType) -> Layout {
        if let t = self._target as? UITextField {
            t.keyboardType = type
        }
        return self
    }
}

//イベント系
extension Layout {
    @discardableResult
    func touchUpInside(_ block:@escaping () -> Void) -> Layout {
        if let c = self._target as? UIControl {
            TouchBlocks.append(c, block: block)
        }
        return self
    }
}

//UIView生成
extension Layout {
    
    class func createSystemTypeBtn(_ title:String) -> UIButton {
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle(title, for:UIControlState())
        return btn
    }
    
    class func createWordWrappingLabel(_ text:String) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.numberOfLines  = 0;
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }
    
    class func createCharWrappingLabel(_ text:String) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.numberOfLines  = 0;
        lbl.lineBreakMode = NSLineBreakMode.byCharWrapping
        return lbl
    }

    class func createExtraLightBlurEffect() -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    }
    
    class func createLightBlurEffect() -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .light))
    }

    class func createDarkBlurEffect() -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    }

}

extension Layout {
    class func roundRect(_ view:UIView, byRoundingCorners corners: UIRectCorner,cornerRadii:CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadii, height: cornerRadii)
        )
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.bounds
        shapeLayer.path = path.cgPath
        view.layer.mask = shapeLayer
    }
    
    func roundRect(byRoundingCorners corners: UIRectCorner,cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: corners, cornerRadii:cornerRadii)
        return self
    }
    
    func roundRectTop(_ cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: ([UIRectCorner.topLeft, UIRectCorner.topRight]), cornerRadii:cornerRadii)
        return self
    }
    
    func roundRectLeft(_ cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: ([UIRectCorner.topLeft, UIRectCorner.bottomLeft]), cornerRadii:cornerRadii)
        return self
    }
    
    func roundRectRight(_ cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: ([UIRectCorner.topRight, UIRectCorner.bottomRight]), cornerRadii:cornerRadii)
        return self
    }
    
    func roundRectBottom(_ cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: ([UIRectCorner.bottomLeft, UIRectCorner.bottomRight]), cornerRadii:cornerRadii)
        return self
    }
    
    func roundRect(_ cornerRadii:CGFloat) -> Layout {
        self._target.layoutIfNeeded()
        Layout.roundRect(self._target, byRoundingCorners: ([UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft, UIRectCorner.bottomRight]), cornerRadii:cornerRadii)
        return self
    }
}

//touchイベントの登録にブロックを渡せるようにする
private var touchBlockStaticList:[TouchBlock] = []
class TouchBlocks {
    class func append(_ owner:UIControl,  block: @escaping () -> Void) {
        touchBlockStaticList.append(
            TouchBlock(owner:owner, block:block)
        )
    }
}

class TouchBlock:NSObject {
    
    fileprivate let _block:() -> Void
    
    init(owner:UIControl,  block: @escaping () -> Void){
        self._block = block
        
        super.init()
        
        owner.addTarget(self, action: #selector(TouchBlock.doAction), for: .touchUpInside)
    }
    
    func doAction(){
        _block()
    }
}
