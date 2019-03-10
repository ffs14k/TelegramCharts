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
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInterface()
        presenter?.viewDidLoad()
    }
    
    
    // MARK: - Private methods
    
    private func configureInterface() {
        
        
    }
    
}


// MARK: - StatisticsViewInput
extension StatisticsViewController: StatisticsViewInput {
    
    
}
