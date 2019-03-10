//
//  UserDefaultsUtils.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import Foundation

struct UserDefaultsUtils {
    
    private static let shared = UserDefaults.standard
    
    static func setValue<T>(for key: UserDefaultsKey, value: T) {
        shared.setValue(value, forKey: key.rawValue)
    }
    
    static func getValue<T>(for key: UserDefaultsKey) -> T? {
        return shared.value(forKey: key.rawValue) as? T
    }
}


enum UserDefaultsKey: String {
    
    case uiMode
}
