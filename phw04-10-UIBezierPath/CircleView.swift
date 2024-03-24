//
//  CircleView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit

class CircleView: ShapeView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        UIColor.gray.setFill()
        UIColor.gray.setStroke() // 設置邊框顏色為黑色
        circlePath.lineWidth = 1.0 // 設置邊框寬度
        circlePath.fill()
        circlePath.stroke() // 繪製邊框

   
    }
}
