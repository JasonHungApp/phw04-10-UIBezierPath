//
//  StarView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit

class StarView: ShapeView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let starPath = UIBezierPath()
        let spikes = 5
        let startAngle = CGFloat(-Double.pi / 2.0)
        let angleIncrement = CGFloat(Double.pi * 2 / Double(spikes))
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius / 2.5
        
        for i in 0..<spikes * 2 {
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let angle = startAngle + CGFloat(i) * angleIncrement
            let point = CGPoint(x: rect.width / 2 + radius * cos(angle), y: rect.height / 2 + radius * sin(angle))
            if i == 0 {
                starPath.move(to: point)
            } else {
                starPath.addLine(to: point)
            }
        }
        starPath.close()
        
        UIColor.gray.setFill() // 設置填充顏色為黃色
        starPath.fill() // 填充路徑
    }
}



