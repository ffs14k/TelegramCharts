//
//  ChartRemote.swift
//  TelegramCharts
//
//  Created by Eugene on 11/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import QuartzCore

struct ChartRemote: Codable {
    let lines: [ChartLineRemote]
    
    enum CodingKeys: String, CodingKey {
        case lines = "chart"
    }
}

struct ChartLineRemote: Codable {
    
    let axis: String
    let type: String?
    let name: String?
    let color: String?
    let values: [Int]
}
