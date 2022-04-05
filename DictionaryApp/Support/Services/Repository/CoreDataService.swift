import CoreData

final class CoreDataService: DictionaryService {
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
}
