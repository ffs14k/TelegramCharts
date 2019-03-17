//
//  ChartControllerView.swift
//  TelegramCharts
//
//  Created by Eugene on 17/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit


// MARK: - Constants
private let scopeMinimumWidth: CGFloat = 140


final class ChartControllerView: UIView {
    
    enum State {
        case initial
        case normal(chart: Chart)
    }
    
    
    // MARK: - Properties
    
    private var state: State = .initial
    private var currentScopeFrame: CGRect = .zero
    private var previousSelfFrame: CGRect = .zero
    
    private let chartMirrorView = ChartMirrorView()
    private let chartScopeView = ScopeView(minimumWidth: scopeMinimumWidth)
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        addSubview(chartMirrorView)
        addSubview(chartScopeView)
        chartScopeView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if previousSelfFrame != frame {
            chartMirrorView.frame = bounds
            chartScopeView.frame = CGRect(x: frame.width - scopeMinimumWidth, y: 0,
                                          width: scopeMinimumWidth, height: frame.height)
            previousSelfFrame = frame
        }
        
    }
    
    
    // MARK: - Public methods
    
    func set(in state: State) {
        
        self.state = state
        
        switch state {
        case .initial:
            chartMirrorView.set(in: .initial)
            currentScopeFrame = .zero
        case .normal(let chart):
            chartMirrorView.set(in: .update(abscissa: chart.abscissa, ordinates: chart.ordinates))
        }
        
    }
    
}


// MARK: - ScopeViewDelegate
extension ChartControllerView: ScopeViewDelegate {
    
    func scopeDidChange(on frame: CGRect) {
        currentScopeFrame = frame
        print(frame)
    }
    
}
