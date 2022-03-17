import Foundation
import UIKit

final class MeaningViewModel {
    // MARK: - Properties
    var definitionString: String?
    var example: NSMutableAttributedString?
    
    private let definition: Definition
    
    // MARK: - Init
    init(definition: Definition) {
        self.definition = definition
        definitionString = definition.definition
        guard let exampleString = definition.example, !exampleString.isEmpty else {
            return
        }
        
        example = NSMutableAttributedString(
            string: "Example: " + exampleString,
            attributes: [
                .font: UIFont.rubik(.regular, size: Dimensions.subtitle)
            ]
        )
        example?.addAttribute(.foregroundColor,
                              value: Colors.lightBlue?.cgColor ?? UIColor.blue.cgColor,
                              range: NSRange(location: 0, length: 8))
    }
}
