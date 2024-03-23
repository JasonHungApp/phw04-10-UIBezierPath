//
//  MagicCirclePart.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

/* 程式參考 https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E6%95%99%E5%AE%A4/52-%E9%81%8B%E7%94%A8-uibezierpath-%E7%B9%AA%E8%A3%BD%E5%8F%AF%E6%84%9B%E5%9C%96%E6%A1%88-%E6%AF%94%E6%96%B9%E9%9B%AA%E4%BA%BA-%E7%B1%B3%E5%A5%87-%E5%8F%AF%E6%84%9B%E5%8B%95%E7%89%A9-5df7a39bef12
*/

import Foundation
import UIKit

extension CGFloat {
    var radin: Self {
        self * Self.pi / 180
    }
}

enum MagicCirclePart {
    case outerCircle
    case innerCircle
    
    case centerCircle
    case centerSquqreA
    case centerSquqreB
    
    case outerTextRound
    case centerTextRound
    
    case finalPieceBorder //jason
    
    
    
    static func drawMagicCircle(color: UIColor, shadowColor: UIColor, centerCircleRadius: CGFloat) -> [MagicCirclePart : CALayer] {
        var magicCircleLayers: [MagicCirclePart : CALayer] = [:]
        
        // 繪製最後一個棋子的外框 //jason
        magicCircleLayers[.finalPieceBorder] =
            doubleCircle(center: CGPoint(x: 200, y: 200),
                         radius: 24, // 外圈的半徑
                         distance: 0, // 內圈和外圈的距離
                         lineWidth: 1, // 線條寬度
                         color: .clear,
                         shadowColor: shadowColor)
        
        magicCircleLayers[.centerCircle] =
            doubleCircle(center: CGPoint(x: 200, y: 200),
                         radius: centerCircleRadius,  //96
                         distance: 1, //30
                         lineWidth: 0.5,  //2
                         color: .red.withAlphaComponent(0.8),
                         shadowColor: shadowColor)
        

        magicCircleLayers[.centerSquqreA] =
            singleSquare(location: CGPoint(x: 65, y: 65),
                         angle: 45,
                         width: 30,  //190
                         lineWidth: 1, //2
                         color: .clear,
                         shadowColor: shadowColor)

        magicCircleLayers[.centerSquqreB] =
            singleSquare(location: CGPoint(x: 65, y: 65),
                         angle: 90,
                         width: 30,  //190
                         lineWidth: 1,  //2
                         color: .clear,
                         shadowColor: shadowColor)

        return magicCircleLayers
    }
}





func singleSquare(location: CGPoint,
                  angle: CGFloat,
                  width: CGFloat,
                  lineWidth: CGFloat,
                  color: UIColor,
                  shadowColor: UIColor? = nil) -> CAShapeLayer {
    let radius: CGFloat = (width * CGFloat(sqrt(2))) / 2
    let radin: CGFloat = angle * CGFloat.pi / 180
    let path = UIBezierPath()
    
    var x: CGFloat = radius * cos(Double(radin)) + radius
    var y: CGFloat = radius * sin(Double(radin)) + radius
    path.move(to: CGPoint(x: x, y: y))

    for index in 1...3 {
        x = radius * cos(Double(radin + (Double(index) * (CGFloat.pi / 2)))) + radius
        y = radius * sin(Double(radin + (Double(index) * (CGFloat.pi / 2)))) + radius
        path.addLine(to: CGPoint(x: x, y: y))
    }
    path.close()
    
    let shape = CAShapeLayer()
    shape.path = path.cgPath
    shape.lineWidth = lineWidth
    shape.fillColor = UIColor.clear.cgColor
    shape.strokeColor = color.cgColor
    shape.frame = CGRect(x: location.x, y: location.y, width: radius * 2, height: radius * 2)
    
    if let shadowColor = shadowColor {
        shape.shadowColor = shadowColor.cgColor
        shape.shadowOpacity = 1
        shape.shadowOffset = CGSize(width: 0, height: 3)
        shape.shadowRadius = 4.0
    }
    
    return shape
}

func doubleCircle(center: CGPoint,
                  radius: CGFloat,
                  distance: CGFloat,
                  lineWidth: CGFloat,
                  color: UIColor,
                  shadowColor: UIColor? = nil) -> CAShapeLayer {
    let shape = CAShapeLayer()
    shape.frame = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    let shapeCenter = CGPoint(x: shape.frame.width / 2, y: shape.frame.height / 2)
    
    let path = UIBezierPath()
    let outerCircleStartPoint = CGPoint(x: shapeCenter.x, y: (shapeCenter.y - radius) + lineWidth)
    let innerCircleStartPoint = CGPoint(x: shapeCenter.x, y: (shapeCenter.y - radius) + lineWidth + distance)
    
    // outer circle
    path.move(to: outerCircleStartPoint)
    path.addArc(withCenter: shapeCenter, radius: radius - lineWidth, startAngle:  -CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2, clockwise: true)
    
    // inner circle
    path.move(to: innerCircleStartPoint)
    path.addArc(withCenter: shapeCenter, radius: radius - distance - lineWidth, startAngle:  -CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2, clockwise: true)
    
    shape.path = path.cgPath
    shape.lineWidth = lineWidth
    shape.fillColor = UIColor.clear.cgColor
    shape.strokeColor = color.cgColor

    if let shadowColor = shadowColor {
        shape.shadowColor = shadowColor.cgColor
        shape.shadowOpacity = 1
        shape.shadowOffset = CGSize(width: 0, height: 3)
        shape.shadowRadius = 4.0
    }
    
    return shape
}
