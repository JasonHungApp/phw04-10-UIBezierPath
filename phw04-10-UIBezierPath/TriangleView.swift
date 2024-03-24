//
//  TriangleView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit

class TriangleView: ShapeView {
    var fillColor: UIColor = .gray // 添加填充顏色屬性，預設為透明色

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: rect.width / 2, y: 0))
        trianglePath.addLine(to: CGPoint(x: rect.width, y: rect.height))
        trianglePath.addLine(to: CGPoint(x: 0, y: rect.height))
        trianglePath.close()
        
        // 填充三角形
        fillColor.setFill()
        trianglePath.fill()
    }
}
