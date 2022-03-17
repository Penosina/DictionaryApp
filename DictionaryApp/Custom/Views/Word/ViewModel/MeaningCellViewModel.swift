import Foundation
import UIKit

final class MeaningCellViewModel {
    // MARK: - Properties
    var definitionString: String?
    var example: NSMutableAttributedString?
    
    var didUpdateData: (() -> Void)?
    
    private let definition: Definition
    
    // MARK: - Init
    init(definition: Definition) {
        self.definition = definition
    }
    
    // MARK: - Public Methods
    func start() {
        definitionString = definition.definition
        example = NSMutableAttributedString(
            string: "Example: " + (definition.example ?? ""),
            attributes: [
                .font: UIFont.rubik(.regular, size: Dimensions.subtitle)
            ]
        )
        example?.addAttribute(.foregroundColor,
                              value: Colors.lightBlue?.cgColor ?? UIColor.blue.cgColor,
                              range: NSRange(location: 0, length: 8))
        
        didUpdateData?()
    }
}
