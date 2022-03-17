struct Word: Codable {
    enum CodingKeys: String, CodingKey {
        case word, phoneticString = "phonetic", phonetics, meanings
    }
    
    let word: String?
    let phonetics: [Phonetics]?
    let meanings: [Meaning]?
    var phonetic: String? {
        setupPhonetic(text: phoneticString ?? "")
    }
    
    private let phoneticString: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        word = try container.decodeIfPresent(String.self,
                                             forKey: .word)
        phoneticString = try container.decodeIfPresent(String.self,
                                                       forKey: .phoneticString)
        phonetics = try container.decodeIfPresent([Phonetics].self,
                                                  forKey: .phonetics)
        meanings = try container.decodeIfPresent([Meaning].self,
                                                 forKey: .meanings)
    }
    
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

struct Phonetics: Codable {
    let text: String?
    let audio: String?
}

struct Meaning: Codable {
    let partOfSpeech: String?
    let definitions: [Definition]?
}

struct Definition: Codable {
    let definition: String?
    let example: String?
}
