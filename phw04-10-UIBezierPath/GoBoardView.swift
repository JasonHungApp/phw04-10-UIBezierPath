//
//  GoBoardView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/21.
//

import UIKit

class GoBoardView: UIView {
    var blackStoneCenters: [CGPoint] = [] // 存儲黑子的中心點
    var whiteStoneCenters: [CGPoint] = [] // 存儲白子的中心點

    // 設定格子的行數和列數
    let numRows = 12
    let numCols = 12
    
    // 設定棋盤的寬度和高度
    var boardWidth = 0.0
    var boardHeight = 0.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        boardWidth = frame.width
        boardHeight = frame.height
        setupLineLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLineLayer()
    }
    
    // 添加線的圖層
     private func setupLineLayer() {
         
         // 計算每個格子的寬度和高度
         let cellWidth = boardWidth / CGFloat(numCols)
         let cellHeight = boardHeight / CGFloat(numRows)
         
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
    
    //目前一顆一顆畫，暫時不用從頭畫
    func drawAllStone(){
        // 計算每個格子的寬度和高度
        let cellWidth = boardWidth / CGFloat(numCols)
        let cellHeight = boardHeight / CGFloat(numRows)
        
        // 繪製白子
        for center in whiteStoneCenters {
            let radius: CGFloat = min(cellWidth, cellHeight) / 2 * 0.8
            
            let stoneLayer = CAShapeLayer()
            let stonePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            stoneLayer.path = stonePath.cgPath
            stoneLayer.fillColor = UIColor.white.cgColor
            stoneLayer.strokeColor = UIColor.black.cgColor  // 設置黑邊的顏色
            stoneLayer.lineWidth = 1.0  // 設置黑邊的寬度
            layer.addSublayer(stoneLayer)
        }
        
        // 繪製黑子
        for center in blackStoneCenters {
            let radius: CGFloat = min(cellWidth, cellHeight) / 2 * 0.8
            let stoneLayer = CAShapeLayer()
            let stonePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            stoneLayer.path = stonePath.cgPath
            stoneLayer.fillColor = UIColor.black.cgColor
            layer.addSublayer(stoneLayer)
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 移除之前的魔法陣圖層
        removeMagicCircleLayers()
        
        // 根據下一顆棋子的顏色繪製最後一顆棋子
        if whiteStoneCenters.count == blackStoneCenters.count {
            if let lastWhiteCenter = whiteStoneCenters.last {
               // drawStone(at: lastWhiteCenter, color: .white)
                drawStoneWithMagicCircle(at: lastWhiteCenter, color: .white)

            }
        } else {
            if let lastBlackCenter = blackStoneCenters.last {
                //drawStone(at: lastBlackCenter, color: .black)
                drawStoneWithMagicCircle(at: lastBlackCenter, color: .black)
            }
        }
        
        /*
         
         線條通常使用 CAShapeLayer 來創建和渲染。主要原因有幾個：

         性能： 使用 CAShapeLayer 來繪製線條通常比使用 UIBezierPath 在 draw(_:) 方法中繪製線條更加高效。CAShapeLayer 是由 Core Animation 來處理的，它使用硬件加速來渲染，因此對於大量的線條或需要頻繁重繪的情況下，使用 CAShapeLayer 會更加快速和有效率。

         動畫： CAShapeLayer 支持基於屬性的動畫。這意味著您可以輕鬆地創建和管理線條的動畫效果，例如線條的顏色、寬度、路徑等。

         圖層隔離： 使用 CAShapeLayer 將線條圖層與其他視圖的圖層分離開來。這意味著線條的渲染不會影響其他視圖，從而提高了應用程序的性能和穩定性。

         總之，使用 CAShapeLayer 來創建和渲染線條具有性能好、支持動畫以及圖層隔離等優點，因此在需要繪製線條的場景中，通常會使用 CAShapeLayer。
         */
        


    }

    // 移除之前的魔法陣圖層
    func removeMagicCircleLayers() {
        layer.sublayers?.forEach { layer in
            if layer.name == "magicCircleLayer" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    // 定義一個函數來繪製棋子
    func drawStone(at center: CGPoint, color: UIColor) {
        // 計算每個格子的寬度和高度
        let cellWidth = boardWidth / CGFloat(numCols)
        let cellHeight = boardHeight / CGFloat(numRows)
        
        let radius: CGFloat = min(cellWidth, cellHeight) / 2 * 0.8
        let stoneLayer = CAShapeLayer()
        let stonePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        stoneLayer.path = stonePath.cgPath
        stoneLayer.fillColor = color.cgColor
        if color == .white {
            stoneLayer.strokeColor = UIColor.black.cgColor  // 設置黑邊的顏色
            stoneLayer.lineWidth = 1.0  // 設置黑邊的寬度
        }
        layer.addSublayer(stoneLayer)
        
        
    }
    
    
    // 定義一個函數來繪製棋子及其周圍的魔法陣
    func drawStoneWithMagicCircle(at center: CGPoint, color: UIColor) {
        // 計算每個格子的寬度和高度
        let cellWidth = boardWidth / CGFloat(numCols)
        let cellHeight = boardHeight / CGFloat(numRows)
        
        let radius: CGFloat = min(cellWidth, cellHeight) / 2 * 0.8
        
        // 繪製棋子
        let stoneLayer = CAShapeLayer()
        let stonePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        stoneLayer.path = stonePath.cgPath
        stoneLayer.fillColor = color.cgColor
        if color == .white {
            stoneLayer.strokeColor = UIColor.black.cgColor  // 設置黑邊的顏色
            stoneLayer.lineWidth = 1.0  // 設置黑邊的寬度
        }
        layer.addSublayer(stoneLayer) // 將棋子添加到視圖的 layer 上
        
        // 繪製魔法陣
        let magicCircleLayers = MagicCirclePart.drawMagicCircle(color: .red, shadowColor: .gray)
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // 將點擊位置轉換為最接近的棋盤交叉點的坐標
        
        let cellWidth = bounds.width / CGFloat(numCols)
        let cellHeight = bounds.height / CGFloat(numRows)
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
