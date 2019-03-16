//
//  CGRect+Helpers.swift
//  TelegramCharts
//
//  Created by Eugene on 16/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    var topLeft: CGPoint {
        return CGPoint(x: minX, y: minY)
    }
    
    var topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }
    
    var mid: CGPoint {
        return CGPoint(x: midX, y: midX)
    }
    
    var midLeft: CGPoint {
        return CGPoint(x: minX, y: midY)
    }
    
    var midTop: CGPoint {
        return CGPoint(x: midX, y: minY)
    }
    
    var midRight: CGPoint {
        return CGPoint(x: maxX, y: midY)
    }
    
    var midBottom: CGPoint {
        return CGPoint(x: midX, y: maxY)
    }
    
}
