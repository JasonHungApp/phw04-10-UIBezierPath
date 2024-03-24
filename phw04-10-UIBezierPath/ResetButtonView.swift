//
//  ResetView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit

class ResetView: UIView {
    
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 繪製重置形狀
        let resetPath = UIBezierPath()
        resetPath.move(to: CGPoint(x: rect.width / 2 - 20, y: rect.height / 2))
        resetPath.addLine(to: CGPoint(x: rect.width / 2 + 20, y: rect.height / 2))
        resetPath.move(to: CGPoint(x: rect.width / 2, y: rect.height / 2 - 20))
        resetPath.addLine(to: CGPoint(x: rect.width / 2, y: rect.height / 2 + 20))
        
        UIColor.red.setStroke() // 設置線的顏色為紅色
        resetPath.lineWidth = 2.0 // 設置線寬
        resetPath.stroke() // 繪製路徑

//        let resetPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
//        UIColor.red.setFill()
//        resetPath.fill()

    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        didResetBoard?() // 觸發回調
    }
}
