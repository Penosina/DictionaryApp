import Foundation
import CoreData

extension DBWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBWord> {
        return NSFetchRequest<DBWord>(entityName: "DBWord")
    }

    @NSManaged public var word: String?
    @NSManaged public var phonetic: String?
    @NSManaged public var phonetics: NSSet?
    @NSManaged public var meanings: NSSet?

}

// MARK: Generated accessors for phonetics
extension DBWord {

    @objc(addPhoneticsObject:)
    @NSManaged public func addToPhonetics(_ value: DBPhonetic)

    @objc(removePhoneticsObject:)
    @NSManaged public func removeFromPhonetics(_ value: DBPhonetic)

    @objc(addPhonetics:)
    @NSManaged public func addToPhonetics(_ values: NSSet)

    @objc(removePhonetics:)
    @NSManaged public func removeFromPhonetics(_ values: NSSet)

}

// MARK: Generated accessors for meanings
extension DBWord {

    @objc(addMeaningsObject:)
    @NSManaged public func addToMeanings(_ value: DBMeaning)

    @objc(removeMeaningsObject:)
    @NSManaged public func removeFromMeanings(_ value: DBMeaning)

    @objc(addMeanings:)
    @NSManaged public func addToMeanings(_ values: NSSet)

    @objc(removeMeanings:)
    @NSManaged public func removeFromMeanings(_ values: NSSet)

}

extension DBWord : Identifiable {

}
