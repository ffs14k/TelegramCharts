//
//  ChatView.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

final class ChartView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Subviews
    
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 2000, height: bounds.height)
        
        
        layer.addSublayer(gradientLayer)
        
    }
    
    
    // MARK: - Private methods
    
    private func initialSetup() {
        
    }
    
    
}



