//
//  StatisticsViewConstroller.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit



protocol StatisticsViewInput: AnyObject {
    
    func setup(with state: StatisticsViewController.State)
}

final class StatisticsViewController: UIViewController {
    
    // MARK: - Local types
    
    enum State {
        
        case failure
        case success(firstChart: Chart)
    }
    
    
    // MARK: - Properties
    
    var presenter: StatisticsViewOutput?
    
    private var heightConstraint: NSLayoutConstraint?
    
    
    // MARK: - Subviews
    
    private let chartView = FollowersChartView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInterface()
        presenter?.viewDidLoad()
        
    }
    
    
    // MARK: - Private methods
    
    private func configureInterface() {
        
        view.backgroundColor = IntefaceUtils.bgColor
        
        let btnPlus = UIButton()
        btnPlus.backgroundColor = .white
        btnPlus.setTitle("PLUS", for: .normal)
        btnPlus.setTitleColor(.black, for: .normal)
        btnPlus.addTarget(self, action: #selector(plusHeight), for: .touchUpInside)
        view.addSubview(btnPlus)
        btnPlus.translatesAutoresizingMaskIntoConstraints = false
        btnPlus.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        btnPlus.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        btnPlus.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnPlus.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let btnMinus = UIButton()
        btnMinus.backgroundColor = .white
        btnMinus.setTitle("MINUS", for: .normal)
        btnMinus.setTitleColor(.black, for: .normal)
        btnMinus.addTarget(self, action: #selector(minusHeight), for: .touchUpInside)
        view.addSubview(btnMinus)
        btnMinus.translatesAutoresizingMaskIntoConstraints = false
        btnMinus.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        btnMinus.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        btnMinus.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnMinus.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartView)
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        heightConstraint = chartView.heightAnchor.constraint(equalToConstant: 350)
        heightConstraint?.isActive = true
        
        
//        let t = TesView()
//        t.frame = CGRect(x: 50, y: 200, width: 200, height: 200)
//        
//        view.addSubview(t)
        
    }
    
    @objc private func plusHeight() {
        
        guard let constr = heightConstraint else { return }
        constr.constant = constr.constant + 30
        chartView.layoutIfNeeded()
        
    }
    
    @objc private func minusHeight() {
        
        guard let constr = heightConstraint else { return }
        constr.constant = constr.constant - 30
        chartView.layoutIfNeeded()
    }
    
}


// MARK: - StatisticsViewInput
extension StatisticsViewController: StatisticsViewInput {
    
    func setup(with state: StatisticsViewController.State) {
        
        switch state {
            
        case .failure: fatalError()
        
        case .success(let firstChart):
            chartView.setup(with: .normal(chart: firstChart))
        }
        
    }
    
}


//class TesView: UIView {
//
//
//
//    private let shape = CAShapeLayer()
//    private var path = UIBezierPath()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//
//        layer.addSublayer(shape)
//
//
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(redraw)))
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    override func layoutSubviews() {
//
//
//        shape.lineWidth = 2
//        shape.strokeColor = UIColor.red.cgColor
//
//
//        path.move(to: bounds.bottomLeft)
//        path.addLine(to: bounds.topRight)
////        path.stroke()
//        shape.path = path.cgPath
//        layer.addSublayer(shape)
//    }
//
//
//    @objc private func redraw() {
//
//        let path = UIBezierPath()
//        path.move(to: bounds.topLeft)
//        path.addLine(to: bounds.bottomRight)
//
//
//
//    }
//
//
//}
