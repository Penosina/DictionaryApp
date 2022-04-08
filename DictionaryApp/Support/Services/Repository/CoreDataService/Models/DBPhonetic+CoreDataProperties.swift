import Foundation
import CoreData

extension DBPhonetic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBPhonetic> {
        return NSFetchRequest<DBPhonetic>(entityName: "DBPhonetic")
    }

    @NSManaged public var text: String?
    @NSManaged public var audio: String?
    @NSManaged public var word: DBWord?

}

extension DBPhonetic : Identifiable {

}
