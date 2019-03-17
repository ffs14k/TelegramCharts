//
//  CGContext+DrawLine.swift
//  TelegramCharts
//
//  Created by Eugene on 17/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import QuartzCore

extension CGContext {
    
    func drawLine(from startPoint: CGPoint, with endpoints: [CGPoint], width: CGFloat,  color: CGColor? = nil) {
        
        if let color = color {
            setStrokeColor(color)
        }
        
        setLineWidth(width)
        
        move(to: startPoint)
        
        endpoints.forEach {
            addLine(to: $0)
        }
        
        strokePath()
    }
    
    
    func drawLine(with lines: [(CGPoint, CGPoint)], width: CGFloat, color: CGColor? = nil) {
        
        if let color = color {
            setStrokeColor(color)
        }
        
        setLineWidth(width)
        
        lines.forEach {
            move(to: $0)
            addLine(to: $1)
        }
        
        strokePath()
    }
    
    func drawLine(from start: CGPoint, to end: CGPoint, width: CGFloat, color: CGColor? = nil) {
        drawLine(with: [(start, end)], width: width, color: color)
    }
    
}
