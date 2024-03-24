//
//  HeartView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit

class HeartView: ShapeView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let heartPath = UIBezierPath()
        
        // 繪製左半邊心形
        heartPath.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        heartPath.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.25), controlPoint: CGPoint(x: rect.minX, y: rect.maxY - rect.height * 0.35))
        heartPath.addArc(withCenter: CGPoint(x: rect.midX - rect.width * 0.25, y: rect.minY + rect.height * 0.25), radius: rect.width * 0.25, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        
        // 繪製右半邊心形
        heartPath.addArc(withCenter: CGPoint(x: rect.midX + rect.width * 0.25, y: rect.minY + rect.height * 0.25), radius: rect.width * 0.25, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        heartPath.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), controlPoint: CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.35))
        
        UIColor.gray.setFill() 
        heartPath.fill() // 填充心形
    }
}
