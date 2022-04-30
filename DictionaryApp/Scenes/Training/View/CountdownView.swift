import UIKit

final class CountdownView: UIView {
    // MARK: - Properties
    private var layers: [CAShapeLayer] = []
    private let shape = CAShapeLayer()
    private let numberLabel = UILabel()
    private lazy var circlePath = UIBezierPath(arcCenter: center,
                                               radius: viewModel?.radius ?? 150,
                                               startAngle: -(.pi / 2),
                                               endAngle: .pi * 2,
                                               clockwise: true)
    private var viewModel: CountdownViewModel?
    
    // MARK: - Public Methods
    func configure(with viewModel: CountdownViewModel) {
        self.viewModel = viewModel
        setup()
        
        bindToViewModel()
    }
    
    // MARK: - Private Methods
    private func setup() {
        backgroundColor = .clear
        layer.addSublayer(shape)
        addSubview(numberLabel)
        
        setupShape()
        setupNumberLabel()
    }
    
    private func setupShape() {
        shape.path = circlePath.cgPath
        shape.lineWidth = 15
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
    }
    
    private func setupNumberLabel() {
        numberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        numberLabel.font = R.font.rubikBold(size: Dimensions.extraLarge)
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateView = { [weak self] countdownItem in
            self?.numberLabel.textColor = countdownItem.color
            self?.numberLabel.text = countdownItem.title
            self?.animateActivityRing(item: countdownItem)
        }
    }
    
    private func animateActivityRing(item: CountdownItem) {
        if item == .go {
            layers.forEach { $0.removeFromSuperlayer() }
            layers.removeAll()
        }
        
        let newShape = CAShapeLayer()
        
        layers.append(newShape)
        layer.addSublayer(newShape)
        
        newShape.path = circlePath.cgPath
        newShape.lineWidth = 15
        newShape.fillColor = UIColor.clear.cgColor
        newShape.strokeColor = item.animationColor?.cgColor
        newShape.strokeEnd = 0
        
        let animation = CABasicAnimation(keyPath: Strings.keyPath)
        animation.toValue = 1
        animation.duration = 1
        animation.fillMode = .forwards
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        newShape.add(animation, forKey: Strings.animationKey)
    }
}

// MARK: - CAAnimationDelegate
extension CountdownView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        viewModel?.makeCount()
    }
}

// MARK: - Strings
private extension Strings {
    static let animationKey = "animation"
    static let keyPath = "strokeEnd"
}

// MARK: - Dimensions
private extension Dimensions {
    static let extraLarge = 56.0
}
