import Foundation
import UIKit

protocol CountdownViewModelDelegate: AnyObject {
    func showQuestionScene()
}

final class CountdownViewModel {
    // MARK: - Properties
    var didUpdateView: ((CountdownItem) -> Void)?
    weak var delegate: CountdownViewModelDelegate?
    
    let radius: CGFloat = 75.0
    
    private let timer = Timer()
    private let countdownItems = [
        CountdownItem.five,
        CountdownItem.four,
        CountdownItem.three,
        CountdownItem.two,
        CountdownItem.one,
        CountdownItem.go
    ]
    private lazy var countdownItemIterator = CountdownItemIterator(items: countdownItems)
    
    // MARK: - Public Methods
    func makeCount() {
        if let countdownItem = countdownItemIterator.next() {
            didUpdateView?(countdownItem)
        } else {
            delegate?.showQuestionScene()
        }
    }
    
    // MARK: - Private Methods
    private func oneSecondPassed() {
        
    }
}
