//
//  StoneShapeView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit


class StoneShapeView: UIView {
    
    var didSelectShape: ((StoneShape) -> Void)? // 選擇棋子形狀的回調
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShapes()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShapes()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorder() // 在 layoutSubviews 中添加邊框
        self.backgroundColor = .white
        
    }
    
    private func addBorder() {
        let borderPath = UIBezierPath(roundedRect: bounds, cornerRadius: 0.0) // 設置圓角半徑為 8
        let borderLayer = CAShapeLayer() // 創建 CAShapeLayer
        borderLayer.path = borderPath.cgPath // 設置 CAShapeLayer 的路徑為 UIBezierPath 的路徑
        borderLayer.strokeColor = UIColor.gray.cgColor // 設置邊框顏色
        borderLayer.lineWidth = 1.0 // 設置邊框寬度
        borderLayer.fillColor = UIColor.clear.cgColor // 清除填充色，只顯示邊框
        
        layer.addSublayer(borderLayer) // 將 CAShapeLayer 添加到視圖的 layer 中
    }
    
    private func setupShapes() {
        let spacex = 80
        let size = 35
        let line1y = Int(bounds.height) / 4
        let line2y = Int(bounds.height * 0.75)
        
        let circleView = CircleView(frame: CGRect(x: 10, y: 10, width: size, height: size))
        circleView.center = CGPoint(x: Int(self.frame.width) / 2 - spacex, y: line1y)
        
        circleView.didSelectShape = {
            self.didSelectShape?(.circle)
        }
        addSubview(circleView)
        
        let squareView = SquareView(frame: CGRect(x: 10 + spacex, y: 10, width: size, height: size))
        squareView.center = CGPoint(x: Int(self.frame.width) / 2, y: line1y)
        
        squareView.didSelectShape = {
            self.didSelectShape?(.square)
        }
        addSubview(squareView)
        
        let triangleView = TriangleView(frame: CGRect(x: 10 + spacex*2, y: 10, width: size, height: size))
        triangleView.center = CGPoint(x: Int(self.frame.width) / 2 + spacex, y: line1y)
        
        triangleView.didSelectShape = {
            self.didSelectShape?(.triangle)
        }
        addSubview(triangleView)
        
        ////////////////////////////////
        let heartView = HeartView(frame: CGRect(x: 10, y: 10+size, width: size, height: size))
        heartView.center = CGPoint(x: Int(self.frame.width) / 2 - spacex, y: line2y)
        
        heartView.didSelectShape = {
            self.didSelectShape?(.heart)
        }
        addSubview(heartView)
        
        let starView = StarView(frame: CGRect(x: 10 + spacex*2, y: 10+size, width: size, height: size))
        starView.center = CGPoint(x: Int(self.frame.width) / 2 , y: line2y)
        
        starView.didSelectShape = {
            self.didSelectShape?(.star)
        }
        addSubview(starView)
    }
    
}
