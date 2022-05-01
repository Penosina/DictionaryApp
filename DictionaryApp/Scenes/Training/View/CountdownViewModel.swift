import Foundation
import UIKit

protocol CountdownViewModelDelegate: AnyObject {
    func showQuestionScene()
}

final class CountdownViewModel {
    // MARK: - Properties
    var didUpdateView: ((CountdownItem) -> Void)?
    var didStopAnimation: (() -> Void)?
    
    weak var delegate: CountdownViewModelDelegate?
    
    let radius: CGFloat = Dimensions.ringRadius
    
    private let countdownItems = [
        CountdownItem.five,
        CountdownItem.four,
        CountdownItem.three,
        CountdownItem.two,
        CountdownItem.one,
        CountdownItem.go
    ]
    private lazy var countdownItemIterator = CountdownItemIterator(items: countdownItems)
    private var timer: Timer?
    
    // MARK: - Actions
    @objc private func makeCount() {
        if let countdownItem = countdownItemIterator.next() {
            didUpdateView?(countdownItem)
        } else {
            timer?.invalidate()
            delegate?.showQuestionScene()
        }
    }
    
    // MARK: - Public Methods
    func start() {
        makeCount()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(makeCount),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func stopAnimation() {
        timer?.invalidate()
        didStopAnimation?()
        countdownItemIterator = CountdownItemIterator(items: countdownItems)
    }
}

// MARK: - Dimensions
private extension Dimensions {
    static let ringRadius = 75.0
}
