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
        case initial
        case normal(chart: Chart)
    }
    
    // MARK: - Properties
    
    private var state: State = .initial
    private let chartControllerView = ChartControllerView()
    private let chartMirror = ChartMirrorView()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(chartMirror)
        addSubview(chartControllerView)
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
        setup(with: .initial)
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
        case .initial:
            chartMirror.set(in: .initial)
            chartControllerView.set(in: .initial)
        case .normal(let chart):
            chartMirror.set(in: .update(abscissa: chart.abscissa, ordinates: chart.ordinates))
            chartControllerView.set(in: .normal(chart: chart))
        }
        
    }
    
    
    // MARK: - Private methods
    
    private func updateFrames() {
        
        let mirrorHeight = frame.height * 0.65
        chartMirror.frame = CGRect(x: 0, y: 0, width: frame.width, height: mirrorHeight)
        
        chartControllerView.frame = CGRect(x: 0, y: mirrorHeight + 10,
                                           width: frame.width,
                                           height: frame.height - mirrorHeight - 10)
    }
    
}



