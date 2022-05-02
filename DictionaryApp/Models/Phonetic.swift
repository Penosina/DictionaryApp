import Foundation

struct Phonetic: Codable {
    let text: String?
    let audio: String?
    var audioURL: URL? {
        guard let audio = audio else {
            return nil
        }
        
        return URL(string: audio)
    }
}
