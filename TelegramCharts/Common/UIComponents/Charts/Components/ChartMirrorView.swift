//
//  ChartMirrorView.swift
//  TelegramCharts
//
//  Created by Eugene on 13/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

final class ChartMirrorView: UIView {
    
    enum State {
        case initial
        case update(abscissa: Abscissa, ordinates: [Ordinate])
    }
    
    
    // MARK: - Properties
    
    private var state: State = .initial
    
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        switch state {
        case .initial:
            restoreMirrorView(in: ctx)
        case let .update(abscissa, ordinates):
            drawChart(with: abscissa, and: ordinates, in: ctx)
        }
        
    }
    
    
    // MARK: - Public methods
    
    func set(in state: State) {
        self.state = state
        self.setNeedsDisplay()
    }
    
    
    // MARK: - Private methods
    
    private func restoreMirrorView(in context: CGContext) {
        
        context.setFillColor(IntefaceUtils.chartBgColor.cgColor)
        context.fill(bounds)
    }
    
    private func drawChart(with abscissa: Abscissa, and ordinates: [Ordinate], in context: CGContext) {
        
        context.setFillColor(IntefaceUtils.chartBgColor.cgColor)
        context.fill(bounds)
        
        let xValues = scaleX(abscissa.values)
        let yScale = currentYScale

        for ordinate in ordinates {
            
            var yValues = scaleY(ordinate.values, with: yScale)
            
            if yValues.count > xValues.count {
                yValues.removeSubrange(yValues.count - xValues.count...xValues.endIndex)
            }
            
            let endpoints = xValues.enumerated().map { (idx, x) -> CGPoint in
                return CGPoint(x: x, y: yValues[idx])
            }
            
            context.drawLine(from: bounds.bottomLeft, with: endpoints, width: 2, color: ordinate.color)
        }
        
    }
    
    
    private func scaleY(_ values: [CGFloat], with yScale: CGFloat) -> [CGFloat] {
        
        let height = frame.height
        let flippedValues = values.map { height - $0 * yScale }
        
        return flippedValues
    }
    
    private func scaleX(_ values: [CGFloat]) -> [CGFloat] {
        
        guard let originedValues = values.origined() else { return values }
        
        let width = frame.width
        guard let maxValue = originedValues.max(), maxValue > width  else { return originedValues }
        
        let scaleFactor = width / maxValue
        let result = originedValues.map { ($0 * scaleFactor) }
        
        return result
    }
    
    
    private var currentYScale: CGFloat {
        
        let maxY = maxYValue
        guard maxY != 0 else { return 0 }
        
        return frame.height / maxY
    }
    
    private var maxYValue: CGFloat {
        
        switch state {
            
        case .initial:
            return 0
            
        case .update(_, let ordinates):
            
            var maxValue: CGFloat = 0
            
            for ordinate in ordinates {
                let max = ordinate.values.max() ?? 0
                if max > maxValue { maxValue = max }
            }
            return maxValue
        }
        
    }
    
}
