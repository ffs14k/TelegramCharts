//
//  StatisticsPresenter.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import Foundation

protocol StatisticsViewOutput: ViewOutput {
    
}

final class StatisticsPresenter {
    
    weak var view: StatisticsViewInput?
    
    let provider = FollowersChartDataProvider()
}


// MARK: - StatisticsViewOutput
extension StatisticsPresenter: StatisticsViewOutput {
    
    func viewDidLoad() {
        
        let decoder = JSONDecoder()
        
        guard let charts = try? decoder.decode([ChartRemote].self, from: chartsJSON) else {
            view?.setup(with: .failure)
            return
        }
        
        let firstChart = charts[0]
        
        
        let chart = provider.createChart(with: firstChart)
        view?.setup(with: .success(firstChart: chart))
    }
    
    
}
