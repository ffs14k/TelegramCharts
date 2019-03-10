//
//  Setupable.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

protocol ViewModelProtocol { }

protocol Setupable {
    
    func setup(with: ViewModelProtocol)
}
