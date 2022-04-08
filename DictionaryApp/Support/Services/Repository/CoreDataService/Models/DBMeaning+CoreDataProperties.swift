import Foundation
import CoreData

extension DBMeaning {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMeaning> {
        return NSFetchRequest<DBMeaning>(entityName: "DBMeaning")
    }

    @NSManaged public var partOfSpeech: String?
    @NSManaged public var definitions: NSSet?
    @NSManaged public var word: DBWord?

}

// MARK: Generated accessors for definitions
extension DBMeaning {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: DBDefinition)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: DBDefinition)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: NSSet)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: NSSet)

}

extension DBMeaning : Identifiable {

}
