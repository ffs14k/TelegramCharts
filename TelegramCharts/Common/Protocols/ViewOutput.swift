//
//  ViewOutput.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

protocol ViewOutput: AnyObject {
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
}

extension ViewOutput {
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
}
