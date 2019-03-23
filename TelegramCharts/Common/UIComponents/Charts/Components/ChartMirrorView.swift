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
    
    private var graph: [CAShapeLayer] = []
    private var currentYScale: CGFloat = 0
    private var previousYScale: CGFloat = 0
    private var state: State = .initial
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = IntefaceUtils.bgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    
    func set(in state: State) {
        self.state = state
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
    override func layoutSubviews() {
        
        handleDrawing()
    }
    
    
    // MARK: - Private methods
    
    
    private func handleDrawing() {
        
        guard frame != .zero else {
            restoreMirrorView()
            return
        }
        
        switch state {
            
        case .initial:
            restoreMirrorView()
            
        case let .update(abscissa, ordinates):
            
            let isFirst = graph.isEmpty
            
            updateGraph(with: ordinates.count)
            
            currentYScale = yScale
            
            let lines = createLines(with: abscissa, and: ordinates)
            
            if currentYScale == previousYScale || isFirst {
                drawChart(with: lines)
            }
            else {
                drawChartAnimatly(with: lines)
            }
            
        }
    }
    
    private func updateGraph(with linesCount: Int) {
        
        let difference = abs(graph.count - linesCount)
        guard difference != 0 else { return }
    
        let ordinatesAdded = difference > 0
        
        if ordinatesAdded {
            
            for _ in 0..<difference {
                let layer = CAShapeLayer()
                layer.lineWidth = 2
                layer.lineCap = .round
                layer.fillColor = UIColor.clear.cgColor
                graph.append(layer)
                self.layer.addSublayer(layer)
            }
            

        }
        else {
            graph.removeSubrange(graph.count - difference...graph.count)
        }
        
    }
    
    private func restoreMirrorView() {
        
        backgroundColor = IntefaceUtils.bgColor
        layer.sublayers = nil
        graph = []
    }
    
    
    private func drawChart(with paths: [(CGPath, CGColor)]) {

        for (index, line) in paths.enumerated() {
            
            graph[index].path = line.0
            graph[index].strokeColor = line.1
        }
        
    }
    
    private func drawChartAnimatly(with paths: [(CGPath, CGColor)]) {
    
        for (index, line) in paths.enumerated() {

            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = 0.35
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.toValue = line.0
            graph[index].strokeColor = line.1
            graph[index].add(animation, forKey: nil)
        }
        
    }
    
    
    private func createLines(with abscissa: Abscissa, and ordinates: [Ordinate]) -> [(CGPath, CGColor)] {
        
        var result: [(CGPath, CGColor)] = []
        let height = frame.height
        let xValues = prepareX(abscissa.values)

        ordinates.forEach { ordinate in
            
            let path = UIBezierPath()
            path.move(to: bounds.bottomLeft)
            
            ordinate.values.enumerated().forEach { (idx, yValue) in
                
                let scaledAndFlippedY = height - yValue * currentYScale
                print(xValues[idx], scaledAndFlippedY)
                path.addLine(to: CGPoint(x: xValues[idx], y: scaledAndFlippedY))
            }
            
            result.append((path.cgPath, ordinate.color))
        }
        
        return result
    }
    
    
    private func prepareX(_ values: [CGFloat]) -> [CGFloat] {
        
        guard let originedValues = values.origined() else { return values }
        
        let width = frame.width
        guard let maxValue = originedValues.max(), maxValue > width  else { return originedValues }
        
        let scaleFactor = width / maxValue
        let result = originedValues.map { ($0 * scaleFactor) }
        
        return result
    }
    
    
    // MARK: - Helpers
    
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
            
            var maxValue: CGFloat = 0
            
            for ordinate in ordinates {
                let max = ordinate.values.max() ?? 0
                if max > maxValue { maxValue = max }
            }
            return maxValue
        }
        
    }
    
}
