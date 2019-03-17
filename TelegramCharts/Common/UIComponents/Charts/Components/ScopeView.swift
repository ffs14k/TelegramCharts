//
//  ScopeView.swift
//  TelegramCharts
//
//  Created by Eugene on 17/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

protocol ScopeViewDelegate: AnyObject {
    
    func scopeDidChange(on frame: CGRect)
}

final class ScopeView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ScopeViewDelegate?
    private let minimumWidth: CGFloat
    private let minimumExpandArea: CGFloat
    
    private let vertivalBordersWidth: CGFloat = 2
    private let horizontalBordersWidth: CGFloat = 8
    
    
    // MARK: - Init
    
    init(minimumWidth: CGFloat) {
        
        self.minimumWidth = minimumWidth
        let expandArea = minimumWidth * 0.3
        minimumExpandArea = expandArea > 40 ? 40 : expandArea
        super.init(frame: .zero)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawBorders(with: context)
    }
    
    
    // MARK: - Private methods
    
    private func initialSetup() {
        
        backgroundColor = .clear
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    private func drawBorders(with context: CGContext) {
        
        let vRect = bounds.insetBy(dx: vertivalBordersWidth / 2, dy: vertivalBordersWidth / 2)
        let verticalEdgesEndpoint = [(vRect.topRight, vRect.topLeft), (vRect.bottomRight, vRect.bottomLeft)]
        context.drawLine(with: verticalEdgesEndpoint, width: vertivalBordersWidth, color: UIColor.white.cgColor)
        
        let hRect = bounds.insetBy(dx: horizontalBordersWidth / 2, dy: horizontalBordersWidth / 2)
        let horizontalEdgesEndpoint = [(hRect.topLeft, hRect.bottomLeft), (hRect.topRight, hRect.bottomRight)]
        context.drawLine(with: horizontalEdgesEndpoint, width: horizontalBordersWidth, color: UIColor.white.cgColor)
    }
    
    private func expandScope(in superFrame: CGRect, currentLocationInSuper: CGPoint) -> CGRect? {
        
        let xTranslation = currentLocationInSuper.x - previousLocationInSuper.x
        let newOrigin = CGPoint(x: frame.origin.x + xTranslation, y: frame.origin.y)
        
        let newWidth = frame.width - xTranslation
        let newSize = CGSize(width: newWidth, height: frame.size.height)
        
        guard newWidth >= minimumWidth, newOrigin.x >= 0 else { return nil }
        
        return CGRect(origin: newOrigin, size: newSize)
    }
    
    private func moveScope(in superFrame: CGRect, currentLocationInSuper: CGPoint) -> CGRect? {
        
        let xTranslation = currentLocationInSuper.x - previousLocationInSuper.x
        let newOrigin = CGPoint(x: frame.origin.x + xTranslation, y: frame.origin.y)
        
        let isNotOutOfLeftEdge = newOrigin.x >= 0
        let isNotOutOfRightEdge = newOrigin.x + frame.width < superFrame.width
        
        guard isNotOutOfLeftEdge, isNotOutOfRightEdge else { return nil }
        
        return CGRect(origin: newOrigin, size: frame.size)
    }
    
    
    // MARK: - Actions
    
    @objc private func handlePan(pan: UIPanGestureRecognizer) {
        
        switch pan.state {
            
        case .began:
            
            startLocation = pan.location(in: self)
            startLocationInSuper = pan.location(in: superview)
            previousLocationInSuper = startLocationInSuper
            
        case .changed:
            
            guard let defeneltySuperView = superview else { return }
            
            let translationX = (pan.translation(in: self).x)
            guard translationX != 0 else { return }
            
            let currentLocationInSuper = pan.location(in: defeneltySuperView)
            var nextFrame: CGRect = .zero
            
            if expandPanLocation.contains(startLocation) {
                
                guard let frame = expandScope(in: defeneltySuperView.frame, currentLocationInSuper: currentLocationInSuper) else {
                    break
                }
                nextFrame = frame
                
            }
            else if (movePanLocation.contains(startLocation)) {
                
                guard let frame = moveScope(in: defeneltySuperView.frame, currentLocationInSuper: currentLocationInSuper) else {
                    break
                }
                nextFrame = frame
            }
            
            guard nextFrame != .zero else { return }
            
            previousLocationInSuper = currentLocationInSuper
            
            delegate?.scopeDidChange(on: nextFrame)
            
            UIView.animate(withDuration: 0.1) {
                self.frame = nextFrame
            }
            
        default:
            break
        }
        
    }
    
    
    // MARK: - Helpers
    
    private var previousLocationInSuper: CGPoint = .zero
    private var startLocationInSuper: CGPoint = .zero
    
    private var startLocation: CGPoint = .zero
    
    private var expandPanLocation: CGRect {
        return CGRect(x: 0, y: 0,
                      width: minimumExpandArea, height: frame.height)
    }
    
    private var movePanLocation: CGRect {
        return CGRect(x: minimumExpandArea + 5, y: 0,
                      width: frame.width - minimumExpandArea - 5, height: frame.height)
    }
    
    
}
