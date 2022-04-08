import Foundation
import CoreData

@objc(DBPhonetic)
public class DBPhonetic: NSManagedObject {
    func transient() -> Phonetic {
        return Phonetic(text: text, audio: audio)
    }
    
    static func from(transient: Phonetic, parent: Word, inContext context: NSManagedObjectContext) -> DBPhonetic {
        var phonetic: DBPhonetic
        
        let request: NSFetchRequest = DBPhonetic.fetchRequest()
        let dataBasePhonetics = (try? context.fetch(request)) ?? []
        if let dbPhonetic = dataBasePhonetics.first(where: { $0.word == DBWord.from(transient: parent, inContext: context) }) {
            phonetic = dbPhonetic
        } else {
            phonetic = DBPhonetic(context: context)
            phonetic.text = transient.text
            phonetic.audio = transient.audio
        }
        
        return phonetic
    }
}
