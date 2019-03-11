//
//  ChartRemote.swift
//  TelegramCharts
//
//  Created by Eugene on 11/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

struct ChartsResponse: Codable {
    let charts: [ChartRemote]
}

struct ChartRemote: Codable {
    let chart: [ChartEntity]
}

struct ChartEntity: Codable {
    
    let axis: String
    let type: String?
    let name: String?
    let color: String?
    let values: [Int]
}
