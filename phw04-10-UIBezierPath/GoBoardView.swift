//
//  GoBoardView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/21.
//

import UIKit

class GoBoardView: UIView {
    var stoneShape: StoneShape = .circle // 選擇的棋子形狀
    
    var blackStoneCenters: [CGPoint] = [] // 存儲黑子的中心點
    var whiteStoneCenters: [CGPoint] = [] // 存儲白子的中心點
    
    // 設定格子的行數和列數
    let numRows = 8
    let numCols = 8
    
    // 設定棋盤的寬度和高度
    var boardWidth: CGFloat = 0.0
    var boardHeight: CGFloat = 0.0
    
    // 計算每個格子的寬度和高度
    var cellWidth: CGFloat = 0.0
    var cellHeight: CGFloat = 0.0
    
    // 設定棋子的大小
    var radius: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        boardWidth = frame.width
        boardHeight = frame.height
        
        // 計算每個格子的寬度和高度
        cellWidth = boardWidth / CGFloat(numCols)
        cellHeight = boardHeight / CGFloat(numRows)
        
        // 設定棋子的大小
        radius = min(cellWidth, cellHeight) / 2 * 0.7
        
        setupLineLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLineLayer()
    }
    
    // MARK: - draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        removeStoneLayer()
        // 移除之前的魔法陣圖層
        removeMagicCircleLayers()
        
        drawAllStone()
        
        
        // 根據下一顆棋子的顏色繪製最後一顆棋子
        if whiteStoneCenters.count == blackStoneCenters.count {
            if let lastWhiteCenter = whiteStoneCenters.last {
                drawStoneWithMagicCircle(at: lastWhiteCenter, color: .white)
                
            }
        } else {
            if let lastBlackCenter = blackStoneCenters.last {
                drawStoneWithMagicCircle(at: lastBlackCenter, color: .black)
            }
        }
    }
    
    
    // 重置操作
    func resetBoard() {
        // 重新初始化棋盤狀態，清空所有棋子等
        // 清空所有棋子
        whiteStoneCenters.removeAll()
        blackStoneCenters.removeAll()
        setupLineLayer()
        
        // 重新繪製棋盤
        setNeedsDisplay()
    }
    
    // 更改棋子形狀的方法
    func changeStoneShape(to shape: StoneShape) {
        stoneShape = shape
        setNeedsDisplay() // 重繪棋盤以更新棋子形狀
    }
    
    // 添加線的圖層
    private func setupLineLayer() {
        
        removeLineLayer()
        
        // 開始繪製
        let path = UIBezierPath()
        
        
        // 繪製水平線（包括最上方和最下方的線）
        for i in 0...numRows {
            let y = CGFloat(i) * cellHeight
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: boardWidth, y: y))
        }
        
        // 繪製垂直線（包括最左邊和最右邊的線）
        for i in 0...numCols {
            let x = CGFloat(i) * cellWidth
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: boardHeight))
        }
        
        // 設定線的顏色和寬度
        UIColor.lightGray.setStroke()
        path.lineWidth = 1.0
        
        // 創建線的圖層
        let lineLayer = CAShapeLayer()
        lineLayer.name = "LineLayer"
        
        lineLayer.path = path.cgPath
        lineLayer.strokeColor = UIColor.lightGray.cgColor
        lineLayer.lineWidth = 1.0
        
        // 將線的圖層添加到視圖的圖層中
        layer.addSublayer(lineLayer)
        
        // 添加動畫效果
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2.0
        lineLayer.add(animation, forKey: "strokeEndAnimation")
    }
    
    func drawAllStone(){
        
        // 繪製白子
        for center in whiteStoneCenters {
            // 繪製棋子
            let stoneLayer = CAShapeLayer()
            stoneLayer.name = "stoneLayer"
            
            let stonePath = createStonePath(for: stoneShape, at: center, with: radius)
            stoneLayer.path = stonePath.cgPath
            
            let color = UIColor.white
            stoneLayer.fillColor = color.cgColor
            if color == .white {
                stoneLayer.strokeColor = UIColor.black.cgColor  // 設置黑邊的顏色
                stoneLayer.lineWidth = 1.0  // 設置黑邊的寬度
            }
            layer.addSublayer(stoneLayer) // 將棋子添加到視圖的 layer 上
        }
        
        // 繪製黑子
        for center in blackStoneCenters {
            
            // 繪製棋子
            let stoneLayer = CAShapeLayer()
            stoneLayer.name = "stoneLayer"
            
            let stonePath = createStonePath(for: stoneShape, at: center, with: radius)
            stoneLayer.path = stonePath.cgPath
            
            let color = UIColor.black
            stoneLayer.fillColor = color.cgColor
            if color == .white {
                stoneLayer.strokeColor = UIColor.black.cgColor  // 設置黑邊的顏色
                stoneLayer.lineWidth = 1.0  // 設置黑邊的寬度
            }
            layer.addSublayer(stoneLayer) // 將棋子添加到視圖的 layer 上
        }
    }
    
    
    
    
    
    func createStonePath(for shape: StoneShape, at center: CGPoint, with radius: CGFloat) -> UIBezierPath {
        switch shape {
        case .circle:
            return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        case .square:
            let sideLength = radius * 2 // 方形的邊長等於圓形的直徑
            return UIBezierPath(rect: CGRect(x: center.x - sideLength / 2, y: center.y - sideLength / 2, width: sideLength, height: sideLength))
        case .triangle:
            let trianglePath = UIBezierPath()
            trianglePath.move(to: CGPoint(x: center.x, y: center.y - radius)) // 上頂點
            trianglePath.addLine(to: CGPoint(x: center.x + radius * cos(CGFloat.pi / 5), y: center.y + radius * sin(CGFloat.pi / 3))) // 右下點
            trianglePath.addLine(to: CGPoint(x: center.x - radius * cos(CGFloat.pi / 5), y: center.y + radius * sin(CGFloat.pi / 3))) // 左下點
            trianglePath.close() // 封閉路徑，形成三角形
            return trianglePath
            
        case .star:
            let starPath = UIBezierPath()
            let spikes = 5
            let startAngle = CGFloat(-Double.pi / 2.0)
            let angleIncrement = CGFloat(Double.pi * 2 / Double(spikes))
            let outerRadius = min(radius, radius)
            let innerRadius = outerRadius / 2.5
            
            for i in 0..<spikes * 2 {
                let radius = i % 2 == 0 ? outerRadius : innerRadius
                let angle = startAngle + CGFloat(i) * angleIncrement
                let point = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
                if i == 0 {
                    starPath.move(to: point)
                } else {
                    starPath.addLine(to: point)
                }
            }
            starPath.close()
            return starPath
            
        case .heart:
            let heartPath = UIBezierPath()
            
            // 繪製左半邊心形
            heartPath.move(to: CGPoint(x: center.x, y: center.y + radius))
            heartPath.addQuadCurve(to: CGPoint(x: center.x - radius, y: center.y - radius/2), controlPoint: CGPoint(x: center.x - radius, y: center.y + radius * 0.35))
            heartPath.addArc(withCenter: CGPoint(x: center.x - radius / 2, y: center.y - radius / 2), radius: radius / 2, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
            
            // 繪製右半邊心形
            heartPath.addArc(withCenter: CGPoint(x: center.x + radius / 2, y: center.y - radius / 2), radius: radius / 2, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
            heartPath.addQuadCurve(to: CGPoint(x: center.x, y: center.y + radius), controlPoint: CGPoint(x: center.x + radius, y: center.y + radius * 0.35))
            
            return heartPath
            
        default:
            return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            
        }
    }
    
    
    // 定義一個函數來繪製棋子及其周圍的魔法陣
    func drawStoneWithMagicCircle(at center: CGPoint, color: UIColor) {
        
        // 繪製棋子
        let stoneLayer = CAShapeLayer()
        stoneLayer.name = "stoneLayer"
        
        
        let stonePath = createStonePath(for: stoneShape, at: center, with: radius)
        stoneLayer.path = stonePath.cgPath
        
        stoneLayer.fillColor = color.cgColor
        if color == .white {
            stoneLayer.strokeColor = UIColor.black.cgColor  // 設置黑邊的顏色
            stoneLayer.lineWidth = 1.0  // 設置黑邊的寬度
        }
        layer.addSublayer(stoneLayer) // 將棋子添加到視圖的 layer 上
        
        
        
        // 繪製魔法陣
        let magicCircleLayers = MagicCirclePart.drawMagicCircle(color: .red, shadowColor: .gray, centerCircleRadius: radius+9)
        
        // 調整魔法陣的中心點與棋子的中心點一致
        let magicCircleCenter = center
        
        // 在棋子的周圍顯示魔法陣的每個部分
        for (_, layer) in magicCircleLayers {
            layer.position = magicCircleCenter // 設置魔法陣部分的位置為棋子的中心點
            layer.name = "magicCircleLayer" // 給圖層命名為 "magicCircleLayer"
            
            layer.zPosition = -1 // 將魔法陣的層級設置為低於棋子，以確保在棋子上層顯示
            self.layer.addSublayer(layer) // 將魔法陣的每個部分添加到視圖的 layer 上
        }
    }
    
    // MARK: - Remove
    
    // 移除之前的魔法陣圖層
    func removeMagicCircleLayers() {
        layer.sublayers?.forEach { layer in
            if layer.name == "magicCircleLayer" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    // 移除之前的棋子圖層
    func removeStoneLayer() {
        layer.sublayers?.forEach { layer in
            if layer.name == "stoneLayer" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    // 移除之前的棋盤線條
    func removeLineLayer() {
        layer.sublayers?.forEach { layer in
            if layer.name == "LineLayer" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // 將點擊位置轉換為最接近的棋盤交叉點的坐標
        let col = min(max(0, Int((touchLocation.x + cellWidth / 2) / cellWidth)), numCols)
        let row = min(max(0, Int((touchLocation.y + cellHeight / 2) / cellHeight)), numRows)
        
        let stoneCenter = CGPoint(x: CGFloat(col) * cellWidth, y: CGFloat(row) * cellHeight)
        
        // 檢查點擊位置是否已經有了黑白子
        if blackStoneCenters.contains(stoneCenter) || whiteStoneCenters.contains(stoneCenter) {
            // 點擊位置已經有了黑白子，取消點擊
            return
        }
        
        // 根據奇偶來決定添加黑子還是白子
        if (blackStoneCenters.count + whiteStoneCenters.count) % 2 == 0 {
            // 偶數，添加黑子
            blackStoneCenters.append(stoneCenter)
        } else {
            // 奇數，添加白子
            whiteStoneCenters.append(stoneCenter)
        }
        
        // 重繪視圖
        setNeedsDisplay()
    }
}
