//
//  StatisticsPresenter.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

protocol StatisticsViewOutput: ViewOutput {
    
}

final class StatisticsPresenter {
    
    weak var view: StatisticsViewInput?
    
}


// MARK: - StatisticsViewOutput
extension StatisticsPresenter: StatisticsViewOutput {
    
    func viewDidLoad() {
        
    }
    
    
}
