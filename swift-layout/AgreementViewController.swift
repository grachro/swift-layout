//
//  AgreementViewController.swift
//  swift-layout
//
//  Created by grachro on 2014/09/07.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController {

    

    
    //アジャイルソフトウェア宣言
    //http://agilemanifesto.org/iso/ja/
    let texts = [
        "私たちは、ソフトウェア開発の実践、あるいは実践を手助けをする活動を通じて、よりよい開発方法を見つけだそうとしている。この活動を通して、私たちは以下の価値に至った。",
        "プロセスやツールよりも個人と対話を、",
        "包括的なドキュメントよりも動くソフトウェアを、",
        "契約交渉よりも顧客との協調を、",
        "計画に従うことよりも変化への対応を、",
        "価値とする。すなわち、左記のことがらに価値があることを認めながらも、私たちは右記のことがらにより価値をおく。",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        let prefix = "・"
        var containerView = self.view
        var baseView:UIView? = nil
        
        for (index, text) in enumerate(texts) {
            
            
            var prefixLabel = Layout.createWordWrappingLabel(prefix)
            prefixLabel.backgroundColor = UIColor.redColor()

            
            
            var bodyLabel = Layout.createWordWrappingLabel(text)
            bodyLabel.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 0, alpha: 0.5)
            let bodyLayout = Layout.regist(bodyLabel, container:containerView)
            
            
            Layout.regist(prefixLabel, container: containerView)
                .topIsSame(bodyLabel) //Topは本文と同じ
                .left(15).fromContainerLeft()
            
            if baseView == nil {
                bodyLayout
                    .top(20).fromContainerTop() //1行目のTopはコンテナのTopからの距離
                    .left(15).fromLeft(prefixLabel)
                    .right(15).fromContainerRight()
            } else {
                bodyLayout
                    .top(20).fromBottom(baseView!) //2行目以降のTopは前の行のBottomからの距離
                    .left(15).fromLeft(prefixLabel)
                    .right(15).fromContainerRight()
            }
            
            baseView = bodyLabel
        }
        

        //戻るボタン
        addReturnBtn()
    }

    var touchBlocks = TouchBlocks()
    
    private func addReturnBtn() {
        let btn = Layout.createSystemTypeBtn("return")
        Layout.regist(btn, container: self.view)
            .bottomIsSameContainer()
            .rightIsSameContainer()
        touchBlocks.append(btn){
            self.dismissViewControllerAnimated(true, completion:nil)
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
