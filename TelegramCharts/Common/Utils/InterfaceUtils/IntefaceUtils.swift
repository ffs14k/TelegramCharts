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
        case .light: return #colorLiteral(red: 0.9373576045, green: 0.9371495843, blue: 0.9543536305, alpha: 1)
        }
    }
    
    static var chartBgColor: UIColor {
        switch IntefaceUtils.uiMode {
        case .dark: return #colorLiteral(red: 0.1310788393, green: 0.1851919591, blue: 0.2486153245, alpha: 1)
        case .light: return #colorLiteral(red: 0.9959948659, green: 0.9961339831, blue: 0.9959508777, alpha: 1)
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
