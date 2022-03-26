import Foundation
import CoreData

// MARK: - DictionaryService
protocol DictionaryService {
    func get(word: String, _ onComplete: @escaping (Word) -> Void, onError: @escaping (Error) -> Void)
    func addToRepository(word: Word)
}

final class WordsRepository: DictionaryService {
    // MARK: - Properties
    private let coreDataContextProvider: CoreDataContextProvider = CoreDataContextProvider()
    private let coreDataService: CoreDataService
    private let remoteService: APIService
    private var context: NSManagedObjectContext {
        coreDataContextProvider.viewContext
    }
    
    // MARK: - Init
    init() {
        coreDataService = CoreDataService(context: coreDataContextProvider.viewContext)
        remoteService = APIService()
    }
    
    // MARK: - Public Methods
    func get(word: String,
                _ onComplete: @escaping (Word) -> Void,
                onError: @escaping (Error) -> Void) {
        let dictionaryService: DictionaryService
        
        if remoteService.isConnected() {
            dictionaryService = remoteService
        } else {
            dictionaryService = coreDataService
        }
        
        dictionaryService.get(word: word.lowercased()) { word in
            onComplete(word)
        } onError: { error in
            onError(error)
        }
    }
    
    func addToRepository(word: Word) {
        coreDataService.addToRepository(word: word)
        
        if context.hasChanges {
            try? context.save()
        }
    }
}
