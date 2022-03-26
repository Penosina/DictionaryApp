import Foundation
import CoreData

extension DBDefinition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBDefinition> {
        return NSFetchRequest<DBDefinition>(entityName: "DBDefinition")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var meaning: DBMeaning?

}

extension DBDefinition : Identifiable {

}
