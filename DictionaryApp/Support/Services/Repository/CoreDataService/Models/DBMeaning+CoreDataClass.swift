import Foundation
import CoreData

@objc(DBMeaning)
public class DBMeaning: NSManagedObject {
    func transient() -> Meaning {
        var definitionsTransient: [Definition] = []
        definitions?.forEach { dbDefinition in
            guard let dbDefinition = dbDefinition as? DBDefinition else { return }
            definitionsTransient.append(dbDefinition.transient())
        }
        
        return Meaning(partOfSpeech: partOfSpeech, definitions: definitionsTransient)
    }
    
    static func from(transient: Meaning, parent: Word, inContext context: NSManagedObjectContext) -> DBMeaning {
        var meaning: DBMeaning
        
        let request: NSFetchRequest = DBMeaning.fetchRequest()
        let dataBaseMeanings = (try? context.fetch(request)) ?? []
        
        if let dbMeaning = dataBaseMeanings.first(where: { $0.word == DBWord.from(transient: parent, inContext: context) }) {
            meaning = dbMeaning
        } else {
            meaning = DBMeaning(context: context)
            meaning.partOfSpeech = transient.partOfSpeech
            transient.definitions?.forEach { definition in
                meaning.addToDefinitions(DBDefinition.from(transient: definition, inContext: context))
            }
        }
        
        return meaning
    }
}
