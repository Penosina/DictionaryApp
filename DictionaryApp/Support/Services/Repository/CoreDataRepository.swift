import CoreData

final class CoreDataRepository<T: NSManagedObject>: Repository {
    
    typealias Entity = T
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[T], Error> {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            if let fetchResults = try context.fetch(fetchRequest) as? [Entity] {
                return .success(fetchResults)
            } else {
                return .failure(CoreDataError.invalidManagedObjectType)
            }
        } catch {
            return .failure(error)
        }
    }
    
    func create() -> Result<T, Error> {
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: context) as? Entity else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
        
        return .success(managedObject)
    }
    
    func delete(entity: T) -> Result<Bool, Error> {
        context.delete(entity)
        return .success(true)
    }
}
