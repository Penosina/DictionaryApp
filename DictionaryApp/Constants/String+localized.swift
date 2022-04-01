import Foundation

extension String {
    func localized(withComment comment: String = "") -> String {
        NSLocalizedString(self,
                          tableName: nil,
                          bundle: .main,
                          value: "",
                          comment: comment)
    }
}
