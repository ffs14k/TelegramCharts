//
//  Collection+OriginedValues.swift
//  TelegramCharts
//
//  Created by Eugene on 19/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

extension Collection where Element: Comparable & Numeric {
    
    // Keep in mind Element is positive
    func origined() -> [Iterator.Element]? {
        
        guard let min = self.min() else { return nil }
        
        let originedCollection = self.map { element -> Self.Element in
            
            return element - min
        }
        
        return originedCollection
    }
    
}
