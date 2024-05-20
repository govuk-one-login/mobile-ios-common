import UIKit

final class CheckmarkLayer: CAShapeLayer {

    let drawingLayer = CAShapeLayer()
    let tickLayer = CAShapeLayer()
    private let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")

    init(frame: CGRect) {
        super.init()
        self.frame = frame
        setupPathing()
        addSublayer(drawingLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("Please initialize from 'init(frame: CGRect)'")
    }

    func playAnimation() {
        drawingLayer.addSublayer(tickLayer)
        tickLayer.strokeEnd = 1
        tickLayer.removeAllAnimations()
        tickLayer.add(pathAnimation, forKey: "strokeEnd")
    }

    private func setupPathing() {
        let pathWidthDivisor = 8.0
        
        let circlePath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width / 2)

        let tickBounds = bounds.inset(by: .init(
            top: bounds.height / 3,
            left: bounds.width / 3,
            bottom: bounds.height / 2.8,
            right: bounds.width / 3)
        )
        
        let tickPath = UIBezierPath()
        tickPath.move(to: CGPoint(x: 0, y: tickBounds.height * 1 / 2))
        tickPath.addLine(to: CGPoint(x: tickBounds.width / 2.5, y: tickBounds.height))
        tickPath.addLine(to: CGPoint(x: tickBounds.width, y: tickBounds.height * 1 / 4))

        drawingLayer.frame = bounds
        drawingLayer.path = circlePath.cgPath
        drawingLayer.fillColor = .none
        drawingLayer.fillRule = .evenOdd
        drawingLayer.cornerRadius = bounds.width / 2
        
        tickLayer.frame = tickBounds
        tickLayer.path = tickPath.cgPath
        tickLayer.strokeColor = UIColor.white.cgColor
        tickLayer.fillColor = nil
        tickLayer.lineWidth = tickBounds.width / pathWidthDivisor
        tickLayer.lineCap = .round
        tickLayer.lineJoin = .round
        
        drawingLayer.borderColor = UIColor.white.cgColor
        drawingLayer.borderWidth = tickBounds.width / pathWidthDivisor
        
        pathAnimation.duration = 0.3
        pathAnimation.fromValue = -0.3
        pathAnimation.toValue = 1
        pathAnimation.timingFunction = .init(name: .easeOut)
    }
}
