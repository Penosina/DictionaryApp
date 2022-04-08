import CoreData

final class CoreDataService: DictionaryDataSource {
    
    // MARK: - Properties
    private let context: NSManagedObjectContext
    
    // MARK: - Init
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Public Methods
    func get(word: String,
             _ onComplete: @escaping (Word) -> Void,
             onError: @escaping (Error) -> Void)  {
        let request: NSFetchRequest = DBWord.fetchRequest()
        let dbWords = (try? context.fetch(request)) ?? []
        
        if let dbWord = dbWords.first(where: { $0.word == word }) {
            do {
                onComplete(try dbWord.transient())
            } catch {
                onError(error)
            }
        } else {
            onError(CoreDataError.noSuchWordInRepository)
        }
    }
    
    func addToRepository(word: Word) -> Void {
        let _ = DBWord.from(transient: word, inContext: context)
    }
    
    func getAll(_ onComplete: @escaping ([Word]) -> Void,
                onError: @escaping (Error) -> Void) {
        let request: NSFetchRequest = DBWord.fetchRequest()
        let dbWords: [DBWord] = (try? context.fetch(request)) ?? []
        var words: [Word] = []
        dbWords.forEach { dbWord in
            do {
                try words.append(dbWord.transient())
            } catch {
                onError(error)
            }
        }
        
        onComplete(words)
    }
}
