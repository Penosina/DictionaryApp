import UIKit

final class CountdownView: UIView {
    // MARK: - Properties
    private var layers: [CAShapeLayer] = []
    private let shape = CAShapeLayer()
    private let numberLabel = UILabel()
    private lazy var circlePath = UIBezierPath(arcCenter: center,
                                               radius: viewModel?.radius ?? 75,
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
        shape.lineWidth = Dimensions.shapeLineWidth
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
    }
    
    private func setupNumberLabel() {
        numberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        numberLabel.font = R.font.rubikBold(size: Dimensions.extraLarge)
    }
    
    private func animateActivityRing(item: CountdownItem) {
        if item == .go {
            removeLayers()
        }
        
        let newShape = CAShapeLayer()
        
        layers.append(newShape)
        layer.addSublayer(newShape)
        
        newShape.path = circlePath.cgPath
        newShape.lineWidth = Dimensions.shapeLineWidth
        newShape.fillColor = UIColor.clear.cgColor
        newShape.strokeColor = item.animationColor?.cgColor
        newShape.strokeEnd = 0
        
        let animation = CABasicAnimation(keyPath: Strings.keyPath)
        animation.toValue = 1
        animation.duration = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        newShape.add(animation, forKey: Strings.animationKey)
    }
    
    private func removeLayers() {
        layers.forEach { $0.removeFromSuperlayer() }
        layers.removeAll()
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateView = { [weak self] countdownItem in
            self?.numberLabel.textColor = countdownItem.color
            self?.numberLabel.text = countdownItem.title
            self?.animateActivityRing(item: countdownItem)
        }
        
        viewModel?.didStopAnimation = { [weak self] in
            self?.removeLayers()
            self?.numberLabel.text = ""
        }
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
    static let shapeLineWidth = 15.0
}
