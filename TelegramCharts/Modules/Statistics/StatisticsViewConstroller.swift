//
//  StatisticsViewConstroller.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit



protocol StatisticsViewInput: AnyObject {
    
//    func setup(with: StatisticsViewController.State)
}

final class StatisticsViewController: UIViewController {
    
    // MARK: - Local types
    
    enum State {
        
        case failure
        case success
    }
    
    
    // MARK: - Properties
    
    var presenter: StatisticsViewOutput?
    
    
    // MARK: - Subviews
    
    private let chartView = ChartView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInterface()
        presenter?.viewDidLoad()
        
 
    }
    
    
    // MARK: - Private methods
    
    private func configureInterface() {
        
        view.backgroundColor = IntefaceUtils.bgColor
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartView)
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        chartView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
}


// MARK: - StatisticsViewInput
extension StatisticsViewController: StatisticsViewInput {
    
    
}
