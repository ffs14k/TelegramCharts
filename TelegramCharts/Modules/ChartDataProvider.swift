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
        
        guard let defenetlyAbcissa = abscissa.first, defenetlyAbcissa.values.isNotEmpty else {
            fatalError()
        }
        
        ordinates.forEach {
            guard $0.values.isNotEmpty else {
                fatalError()
            }
        }
        
        let abscissCGFloatValues = defenetlyAbcissa.values.map { CGFloat($0) }
        let chartAbscissa = Abscissa(values: abscissCGFloatValues)
        
        let chartOrdinates = ordinates.enumerated().map { (idx, ordinateRemote) -> Ordinate in
            
            let type = LineDashPattern(rawValue: ordinateRemote.type ?? "") ?? .none
            let name = ordinateRemote.name ?? "ordinate \(idx)"
            let color = UIColor(hex: ordinateRemote.color ?? "", alpha: 1, defaultColor: .red).cgColor
            
            let ordinateCGFloatValues = ordinateRemote.values.map { CGFloat($0) }
            let ordinate = Ordinate(type: type, name: name, color: color, values: ordinateCGFloatValues)
            
            return ordinate
        }
        
        return Chart(abscissa: chartAbscissa, ordinates: chartOrdinates)
    }
    
}

