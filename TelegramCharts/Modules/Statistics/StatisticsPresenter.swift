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
    
}


// MARK: - StatisticsViewOutput
extension StatisticsPresenter: StatisticsViewOutput {
    
    func viewDidLoad() {
        
        let decoder = JSONDecoder()
        
        let jsonResponse = try? decoder.decode([ChartRemote].self, from: chartsJSON)
        
        print(jsonResponse!)
        
    }
    
    
}
