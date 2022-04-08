import Foundation
import CoreData

final class WordsRepository: Repository {
    
    // MARK: - Properties
    private let coreDataContextProvider: CoreDataContextProvider = CoreDataContextProvider()
    private let localService: DictionaryDataSource
    private let remoteService: DictionaryDataSource
    private var context: NSManagedObjectContext {
        coreDataContextProvider.viewContext
    }
    
    // MARK: - Init
    init() {
        localService = CoreDataService(context: coreDataContextProvider.viewContext)
        remoteService = APIService()
    }
    
    // MARK: - Public Methods
    func get(word: String,
                _ onComplete: @escaping (Word) -> Void,
                onError: @escaping (Error) -> Void) {
        let dictionaryService: DictionaryDataSource
        
        if APIService.isConnected() {
            dictionaryService = remoteService
        } else {
            dictionaryService = localService
        }
        
        dictionaryService.get(word: word.lowercased()) { word in
            onComplete(word)
        } onError: { error in
            onError(error)
        }
    }
    
    func getAll(_ onComplete: @escaping (_ words: [Word]) -> Void,
                onError: @escaping (Error) -> Void) {
        localService.getAll { words in
            onComplete(words)
        } onError: { error in
            onError(error)
        }
    }
    
    func addToRepository(word: Word) {
        localService.addToRepository(word: word)
        
        if context.hasChanges {
            try? context.save()
        }
    }
}
