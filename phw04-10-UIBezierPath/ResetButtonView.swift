//
//  ResetView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit

class ResetButtonView: UIView {
    
    var didResetBoard: (() -> Void)? // 定義回調 closure
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear // 設置背景顏色為透明
        setupGesture() // 設置點擊手勢
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear // 設置背景顏色為透明
        setupGesture() // 設置點擊手勢
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
        borderLayer.strokeColor = UIColor.orange.cgColor // 設置邊框顏色
        borderLayer.lineWidth = 1.0 // 設置邊框寬度
        borderLayer.fillColor = UIColor.clear.cgColor // 清除填充色，只顯示邊框
        
        layer.addSublayer(borderLayer) // 將 CAShapeLayer 添加到視圖的 layer 中

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 繪製重置形狀
        let resetPath = UIBezierPath()
        resetPath.move(to: CGPoint(x: rect.width / 2 - 15, y: rect.height / 2))
        resetPath.addLine(to: CGPoint(x: rect.width / 2 + 15, y: rect.height / 2))
        resetPath.move(to: CGPoint(x: rect.width / 2, y: rect.height / 2 - 15))
        resetPath.addLine(to: CGPoint(x: rect.width / 2, y: rect.height / 2 + 15))
        
        UIColor.orange.setStroke() 
        resetPath.lineWidth = 1.0 // 設置線寬
        resetPath.stroke() // 繪製路徑
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        didResetBoard?() // 觸發回調
    }
}
