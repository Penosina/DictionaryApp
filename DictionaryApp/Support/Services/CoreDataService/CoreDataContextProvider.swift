import CoreData

final class CoreDataContextProvider {
    // MARK: - Properties
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private let persistentContainer: NSPersistentContainer
    
    // MARK: - Init
    init() {
        persistentContainer = NSPersistentContainer(name: Strings.coreDataModelName)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load CoreData stack: \(error)")
            }
        }
    }
}

// MARK: - Strings
private extension Strings {
    static let coreDataModelName = "Model"
}
