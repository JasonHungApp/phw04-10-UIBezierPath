//
//  SquareView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit

class SquareView: ShapeView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let squarePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        UIColor.gray.setFill()
        squarePath.fill()
    }
}
