import Foundation

protocol Repository {
    func get(word: String,
             _ onComplete: @escaping (Word) -> Void,
             onError: @escaping (Error) -> Void)
    func addToRepository(word: Word)
    func getAll(_ onComplete: @escaping (_ words: [Word]) -> Void,
                onError: @escaping (Error) -> Void)
}
