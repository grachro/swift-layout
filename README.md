swift-layout
============

swift-layoutは、Auto Layoutコーディングを助けるためのSwiftクラスです。
"swift-layout" is use Swift language Auto Layout coding helpler class.

Usage
--------
Just add Layout.swift to your project.


Sample
--------

normal swift code.
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
Layout.addSubView(UIView(), superview: superView)
    .left(50).fromLeft(superView)
    .top(50).fromTop(superView)
    .width(100)
    .height(100)
    .backgroundColor(UIColor.blueColor())
````
or
````swift
Layout.addUIView(superview: superView)
    .left(50).fromSuperviewLeft()
    .top(50).fromSuperviewTop()
    .width(100)
    .height(100)
    .backgroundColor(UIColor.blueColor())
````

roundRect
--------
````swift
Layout.addSubView(...)
    ...
    .roundRectTop(CGFlow)
````
or
````
    .roundRectRight(CGFlow)
    or
    .roundRectLeft(CGFlow)
    or
    .roundRectBottom(CGFlow)
    or
    .roundRect(byRoundingCorners: (UIRectCorner.TopLeft | UIRectCorner.BottomRight), cornerRadii: CGFlow)
    or
    .roundRect(CGFlow)
````


blog
--------
[SwiftでAutoLayoutを楽に書くには] http://d.hatena.ne.jp/grachro/20140908
[SwiftでAuto Layout設定した直後に一部を角丸表示] http://d.hatena.ne.jp/grachro/20140928

change history
--------
v0.4
change method name Layout.regist(...) to Layout.addSubView(...)


