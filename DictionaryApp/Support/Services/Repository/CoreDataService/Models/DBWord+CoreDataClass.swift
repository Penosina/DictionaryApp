import Foundation
import CoreData

@objc(DBWord)
public class DBWord: NSManagedObject {
    func transient() throws -> Word {
        guard let word = word else {
            throw CoreDataError.invalidManagedObjectType
        }
        
        var phoneticsTransient: [Phonetic] = []
        phonetics?.forEach { dbPhonetic in
            guard let dbPhonetic = dbPhonetic as? DBPhonetic else { return }
            phoneticsTransient.append(dbPhonetic.transient())
        }
        
        var meaningsTransient: [Meaning] = []
        meanings?.forEach { dbMeaning in
            guard let dbMeaning = dbMeaning as? DBMeaning else { return }
            meaningsTransient.append(dbMeaning.transient())
        }
        
        return Word(word: word,
                    phonetics: phoneticsTransient,
                    meanings: meaningsTransient,
                    phonetic: phonetic,
                    learnCoef: learnCoef)
    }
    
    static func from(transient: Word, inContext context: NSManagedObjectContext) -> DBWord {
        var word: DBWord
        
        let request: NSFetchRequest = DBWord.fetchRequest()
        let dataBaseWords = (try? context.fetch(request)) ?? []
        
        if let dbWord = dataBaseWords.first(where: { $0.word == transient.word }) {
            word = dbWord
        } else {
            word = DBWord(context: context)
            word.word = transient.word
            word.phonetic = transient.phonetic
            word.learnCoef = 0.0
            transient.phonetics?.forEach { phonetic in
                word.addToPhonetics(DBPhonetic.from(transient: phonetic,
                                                    parent: transient,
                                                    inContext: context))
            }
            
            transient.meanings?.forEach { meaning in
                word.addToMeanings(DBMeaning.from(transient: meaning,
                                                  parent: transient,
                                                  inContext: context))
            }
        }
        
        return word
    }
}
