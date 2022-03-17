struct Word: Codable {
    let word: String?
    let phontic: String?
    let phonetics: [Phonetics]?
    let meanings: [Meaning]?
}

struct Phonetics: Codable {
    let text: String?
    let audio: String?
}

struct Meaning: Codable {
    let pertOfSpeech: String?
    let definitions: [Definition]?
}

struct Definition: Codable {
    let definition: String?
    let example: String?
}
