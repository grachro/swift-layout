swift-layout
============

SwiftでのAuto Layoutコーディングを助けるためのフレームワークです。


Usage
--------
Just add Layout.swift to your project.


Sample
--------

nomarl swift code.
````swift
let view = UIView()

view.setTranslatesAutoresizingMaskIntoConstraints(false)
superView.addSubview(view)
let constraints:[NSLayoutConstraint] = [
    NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: superView, attribute: .Top, multiplier: 1.0, constant: 50),
    NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: superView, attribute: .Left, multiplier: 1.0, constant: 50),
    NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100),
    NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100),
]
superView.addConstraints(constraints)
view.backgroundColor = UIColor.blueColor()
````

swift-layout code.
````swift
Layout.regist(UIView(), superview: superView)
    .left(50).fromLeft(superView)
    .top(50).fromTop(superView)
    .width(100)
    .height(100)
    .backgroundColor(UIColor.blueColor())
````

or
````swift
Layout.registUIView(superview: superView)
    .left(50).fromSuperviewLeft()
    .top(50).fromSuperviewTop()
    .width(100)
    .height(100)
    .backgroundColor(UIColor.blueColor())
````

roundRect
--------
http://d.hatena.ne.jp/grachro/20140928/1411910831
