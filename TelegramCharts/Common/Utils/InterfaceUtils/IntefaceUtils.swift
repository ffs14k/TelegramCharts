//
//  IntefaceUtils.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

struct IntefaceUtils {
    
    static var bgColor: UIColor {
        
        switch IntefaceUtils.uiMode {
        case .dark: return #colorLiteral(red: 0.1601548493, green: 0.1646694541, blue: 0.1861729324, alpha: 1)
        case .light: return #colorLiteral(red: 0.9607843137, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        }
        
    }
    
    static var uiMode: UIMode {
        get {
            guard let mode = UserDefaultsUtils.getValue(for: .uiMode) as String? else { return .light }
            return UIMode(rawValue: mode)!
        }
        set {
            UserDefaultsUtils.setValue(for: .uiMode, value: newValue.rawValue)
        }
    }
    
    
    // MARK: - Helpers
    

    
}
