import Foundation

struct Word: Codable {
    let word: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
    let phonetic: String?
    var phoneticString: String? {
        setupPhonetic(text: phonetic ?? "")
    }
    var learnCoef: Double = 0.0
    
    private func setupPhonetic(text: String) -> String {
        guard text.count > 2 else {
            return text
        }
        
        let start = text.index(text.startIndex, offsetBy: 1)
        let end = text.index(text.endIndex, offsetBy: -2)
        let range = start...end
        
        return  "[\(String(text[range]))]"
    }
}

// MARK: - Equatable
extension Word: Equatable {
    static func == (lhs: Word, rhs: Word) -> Bool {
        lhs.word == rhs.word
    }
}
