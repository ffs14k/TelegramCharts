//
//  Chart.swift
//  TelegramCharts
//
//  Created by Eugene on 13/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import QuartzCore


struct Chart {
    let abscissa: Abscissa
    let ordinates: [Ordinate]
}

struct Abscissa {
    
    let values: [CGFloat]
}

struct Ordinate {
    
    let type: LineDashPattern
    let name: String
    let color: CGColor
    let values: [CGFloat]
}

enum LineDashPattern {
    case none
    case dash
}
