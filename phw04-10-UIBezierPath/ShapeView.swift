//
//  ShapeView.swift
//  phw04-10-UIBezierPath
//
//  Created by jasonhung on 2024/3/24.
//

import UIKit

class ShapeView: UIView {
    var didSelectShape: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white // 設置背景顏色為白色
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white // 設置背景顏色為白色
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        didSelectShape?()
    }
}
