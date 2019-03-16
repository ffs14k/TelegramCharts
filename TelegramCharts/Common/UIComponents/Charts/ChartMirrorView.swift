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
    
    
    private var state: State = .initial
    
    
    func set(in state: State) {
        self.state = state
        setNeedsDisplay()
    }
    
    
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
    
    private func restoreMirrorView(in context: CGContext) {
        
        context.setFillColor(IntefaceUtils.bgColor.cgColor)
        context.fill(bounds)
    }
    
    private func drawChart(with abscissa: Abscissa, and ordinates: [Ordinate], in context: CGContext) {
        
        context.setFillColor(IntefaceUtils.bgColor.cgColor)
        context.fill(frame)
        
        let xValues = scaleX(abscissa.values)
        let sacleY = yScale

        for ordinate in ordinates {

            context.setStrokeColor(ordinate.color)

            let path = UIBezierPath()
            path.move(to: frame.bottomLeft)
            path.lineWidth = 2

            let yValues = scaleY(ordinate.values, with: sacleY)


            for (idx, y) in yValues.enumerated() {

                guard let x = xValues[safe: idx] else { return }

                path.addLine(to: CGPoint(x: x, y: y))
            }

            path.stroke()

        }

        context.strokePath()
        
    }
    
    
    private func scaleY(_ values: [CGFloat], with yScale: CGFloat) -> [CGFloat] {
        
        let height = frame.height
        let flippedValues = values.map { height - $0 * yScale }
        
        return flippedValues
    }
    
    private func scaleX(_ values: [CGFloat]) -> [CGFloat] {
        
        guard let minValue = values.min() else { return [] }
        let originedValues = values.map { $0 - minValue }
        
        let width = frame.width
        guard let maxValue = originedValues.max(), maxValue > width  else { return originedValues }
        
        let scaleFactor = width / maxValue
        let result = originedValues.map { ($0 * scaleFactor) }
        
        return result
    }
    
    
    private var yScale: CGFloat {
        
        let maxY = maxYValue
        guard maxY != 0 else { return 0 }
        
        return frame.height / maxY
    }
    
    private var maxYValue: CGFloat {
        
        switch state {
            
        case .initial:
            return 0
            
        case .update(_, let ordinates):
            
            var maxValues = Array(repeating: CGFloat(0), count: ordinates.count)
            
            for (idx, ordinate) in ordinates.enumerated() {
                maxValues[idx] = CGFloat(ordinate.values.max() ?? 0)
            }
            return maxValues.max() ?? 0
        }
        
    }
    
}
