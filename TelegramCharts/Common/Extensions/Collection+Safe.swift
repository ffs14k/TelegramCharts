//
//  Collection+Safe.swift
//  TelegramCharts
//
//  Created by Eugene on 16/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

extension Collection {
    
    subscript(safe index: Index) -> Iterator.Element? {
        
        guard indices.contains(index) else { return nil}
        return self[index]
    }
    
}
