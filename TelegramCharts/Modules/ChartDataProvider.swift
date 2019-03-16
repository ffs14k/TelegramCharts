//
//  ChartDataProvider.swift
//  TelegramCharts
//
//  Created by Eugene on 13/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

protocol ChardDataProvider {
    
    func createChart(with chart: ChartRemote) -> Chart
}

final class FollowersChartDataProvider: ChardDataProvider {
    
    func createChart(with chart: ChartRemote) -> Chart {
        
        let abscissa = chart.lines.filter { $0.axis == "x" }
        let ordinates = chart.lines.filter { $0.axis == "y" }
        
        guard let defenetlyAbcissa = abscissa.first else {
            fatalError()
        }
        
        guard ordinates.isNotEmpty else {
            fatalError()
        }
        
        let abscissCGFloatValues = defenetlyAbcissa.values.map { CGFloat($0) }
        
        let chartAbscissa = Abscissa(values: abscissCGFloatValues)
        
//        var chartOrdinate: [Ordinate<Int>] = []
        
        
        let chartOrdinates = ordinates.enumerated().map { (idx, ordinateRemote) -> Ordinate in
            
            var type: LineDashPattern = .none
            var name = "y \(idx)"
            var color = UIColor.black.cgColor
            
            if let ordinateRemoteType = ordinateRemote.type {
                // TODO
            }
            
            if let ordName = ordinateRemote.name {
                name = ordName
            }
            
            if let ordColor = ordinateRemote.color {
                color = UIColor(hex: ordColor).cgColor
            }
            
            let cgFloatValues = ordinateRemote.values.map { CGFloat($0) }
            
            let ordinate = Ordinate(type: type, name: name, color: color, values: cgFloatValues)
            return ordinate
        }
        
        
        return Chart(abscissa: chartAbscissa, ordinates: chartOrdinates)
    }
    
}

