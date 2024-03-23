//
//  ViewController.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addTriangleLayer()
        addGoBoardView()
        
        
       

    }
    
    func addTriangleLayer(){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 110, y: 0))
        path.addLine(to: CGPoint(x: 90, y: 70))
        path.close()
        
        let triangleLayer = CAShapeLayer()
        triangleLayer.fillColor = UIColor.init(red: 0.7, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        triangleLayer.path = path.cgPath
        
        
        
        view.layer.addSublayer(triangleLayer)
    }
    
    func addGoBoardView(){
        // 創建 GoBoardView
        let boardView = GoBoardView(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
        boardView.backgroundColor = UIColor.white
        
        // 將 GoBoardView 添加到視圖中
        view.addSubview(boardView)
    }
    
    //test layer
    func addGoBoardLayer(){
        // 設定棋盤的寬度和高度
        let boardWidth = 300.0
        let boardHeight = 300.0
        
        // 設定格子的行數和列數
        let numRows = 12
        let numCols = 12
        
        // 計算每個格子的寬度和高度
        let cellWidth = boardWidth / CGFloat(numCols)
        let cellHeight = boardHeight / CGFloat(numRows)
        
        // 開始繪製
        let path = UIBezierPath()
        

        // 繪製水平線（包括最上方和最下方的線）
        for i in 0...numRows {
            let y = CGFloat(i) * cellHeight
            path.move(to: CGPoint(x: 50, y: y+100))
            path.addLine(to: CGPoint(x: boardWidth+50, y: y+100))
        }

        // 繪製垂直線（包括最左邊和最右邊的線）
        for i in 0...numCols {
            let x = CGFloat(i) * cellWidth
            path.move(to: CGPoint(x: x+50, y: 0+100))
            path.addLine(to: CGPoint(x: x+50, y: boardHeight+100))
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
        view.layer.addSublayer(lineLayer)
    }


}


#Preview {
    UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
}
