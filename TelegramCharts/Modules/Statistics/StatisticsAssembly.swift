//
//  StatisticsAssembly.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

final class StatisticsAssembly {
    
    static func assembleModule() -> UIViewController {
        
        let view = StatisticsViewController()
        let presenter = StatisticsPresenter()
        
        view.presenter = presenter
        
        presenter.view = view
        
        return view
    }
    
}
