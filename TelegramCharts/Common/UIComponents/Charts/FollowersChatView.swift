//
//  FollowersChartView.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

final class FollowersChartView: UIView {
    
    enum State {
        case none
        case normal(chart: Chart)
    }
    
    // MARK: - Properties
    
    private var state: State = .none
    private let chartMirror = ChartMirrorView()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(chartMirror)
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrames()
    }
    
    
    // MARK: - Public methods
    
    func setup(with state: State) {
        
        self.state = state
        
        switch state {
        case .none:
            chartMirror.set(in: .initial)
        case .normal(let chart):
            chartMirror.set(in: .update(abscissa: chart.abscissa, ordinates: chart.ordinates))
        }
        
        chartMirror.setNeedsDisplay()
    }
    
    
    // MARK: - Private methods
    
    private func updateFrames() {
        chartMirror.frame = self.bounds
        setup(with: state)
    }
    
}



