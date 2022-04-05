import Foundation
import CoreData

@objc(DBDefinition)
public class DBDefinition: NSManagedObject {
    func transient() -> Definition {
        return Definition(definition: definition, example: example)
    }
    
    static func from(transient: Definition, inContext context: NSManagedObjectContext) -> DBDefinition {
        var definition: DBDefinition
        
        let request: NSFetchRequest = DBDefinition.fetchRequest()
        let dataBaseDefinitions = (try? context.fetch(request)) ?? []
        
        if let dbDefinition = dataBaseDefinitions.first(where: { $0.definition == transient.definition && $0.example == transient.example }) {
            definition = dbDefinition
        } else {
            definition = DBDefinition(context: context)
            definition.definition = transient.definition
            definition.example = transient.example
        }
        
        return definition
    }
}
