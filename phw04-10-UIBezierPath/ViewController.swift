//
//  ViewController.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/21.
//

import UIKit

class ViewController: UIViewController {
    
    var goBoardView: GoBoardView!
    var selectStoneShapeView: StoneShapeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加隨機三角形到背景視圖
        addRandomTrianglesToBackground()
        
        addBlackBackgroundView()
        addTriangleLayer()
        addGoBoardView()
        setupSelectShapeView()
        setupResetView()
    }
    
    func addBlackBackgroundView() {
        let blackBGView = UIView(frame: CGRect(x: 30, y: 70, width: 350, height: 650))
        blackBGView.backgroundColor = .black.withAlphaComponent(0.2)
        blackBGView.center.x = self.view.center.x
        self.view.addSubview(blackBGView)
    }
    
    func addTriangleLayer(){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -20, y: 0))
        path.addLine(to: CGPoint(x: 130, y: 0))
        path.addLine(to: CGPoint(x: 70, y: 70))
        path.close()
        
        let triangleLayer = CAShapeLayer()
        triangleLayer.fillColor = UIColor(red: 0.7, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        triangleLayer.path = path.cgPath
        
        view.layer.addSublayer(triangleLayer)
    }
    
    func addGoBoardView(){
        // 創建 GoBoardView
        goBoardView = GoBoardView(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
        goBoardView.center = CGPoint(x: view.frame.width / 2, y: 250)
        goBoardView.backgroundColor = UIColor.white
        // 將 GoBoardView 添加到視圖中
        view.addSubview(goBoardView)
    }
    
    private func setupResetView() {
        // 創建 setupResetView
        let resetButtonView = ResetButtonView(frame: CGRect(x: 0, y: 450, width: 40, height: 40))
        resetButtonView.center = CGPoint(x: view.frame.width / 2, y: 460)
        resetButtonView.didResetBoard = { [weak self] in
            self?.goBoardView.resetBoard() // 調用 GoBoardView 的 resetBoard 方法
        }
        view.addSubview(resetButtonView)
    }
    
    private func setupSelectShapeView() {
        // 創建 SelectStoneShapeView
        let selectStoneShapeView = StoneShapeView(frame: CGRect(x: 100, y: 600, width: view.frame.width-100, height: 160))
        selectStoneShapeView.center = CGPoint(x: view.frame.width / 2, y: 600)
        selectStoneShapeView.didSelectShape = { [weak self] shape in
            self?.goBoardView.changeStoneShape(to: shape) // 調用 GoBoardView 的 changeStoneShape 方法
        }
        view.addSubview(selectStoneShapeView)
    }
    
    func addRandomTrianglesToBackground() {
        // 獲取 ViewController 的背景視圖大小
        let backgroundSize = view.bounds.size
        // 設置要生成的三角形數量
        let triangleCount = 50
        // 生成隨機大小及形狀的三角形並添加到背景視圖中
        for _ in 0..<triangleCount {
            // 隨機生成三角形的位置
            let randomX = CGFloat.random(in: 0..<backgroundSize.width)
            let randomY = CGFloat.random(in: 0..<backgroundSize.height)
            let randomPoint = CGPoint(x: randomX, y: randomY)
            // 隨機生成三角形的大小
            let randomSize = CGFloat.random(in: 20...100)
            // 創建三角形視圖
            let triangleView = TriangleView(frame: CGRect(x: randomPoint.x, y: randomPoint.y, width: randomSize, height: randomSize))
            // 設置三角形視圖的填充顏色為隨機顏色
            triangleView.fillColor = UIColor.random()
            triangleView.transform = CGAffineTransform(rotationAngle: randomRotationAngle()) // 隨機旋轉角度
            triangleView.backgroundColor = .clear
            // 添加三角形視圖到背景視圖
            view.addSubview(triangleView)
        }
    }
    
    private func randomRotationAngle() -> CGFloat {
        return CGFloat.random(in: 0...(2 * CGFloat.pi)) // 隨機生成旋轉角度
    }
}

extension UIColor {
    static func random() -> UIColor {
        // 生成隨機的RGB顏色
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 0.5)
    }
}


#Preview {
    UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
}
