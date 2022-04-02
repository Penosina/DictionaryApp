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
                .font: R.font.rubikRegular(size: Dimensions.subtitle) as Any
            ]
        )
        example?.addAttribute(.foregroundColor,
                              value: R.color.lightBlue()?.cgColor ?? UIColor.blue.cgColor,
                              range: NSRange(location: 0, length: 8))
    }
}
