final class TestCompiler {
    // MARK: - Properties
    private let words: [Word]
    
    // MARK: - Init
    init(words: [Word]) {
        self.words = words.sorted(by: { $0.learnCoef < $1.learnCoef })
    }
    
    // MARK: - Public Methods
    func compileTest() -> Result<[TrainingTask], Error> {
        guard !words.isEmpty else {
            return .failure(Errors.emptyDictionary)
        }
        
        var trainingTasks: [TrainingTask] = []
        for word in words {
            if trainingTasks.count >= 10 { break }
            
            let wordDefinitions = getWordDefinitions(word: word)
            if let question = wordDefinitions.randomElement() {
                let wrongAnswers = getWordsWithout(exceptionWord: word)
                trainingTasks.append(TrainingTask(question: question,
                                                  wrongAnswers: wrongAnswers,
                                                  rightAnswer: word))
            }
        }
        
        return .success(trainingTasks)
    }
    
    // MARK: - Private Methods
    private func getWordDefinitions(word: Word) -> [String] {
        var wordDefinitions: [String] = []
        
        word.meanings?.forEach {
            $0.definitions?.forEach {
                if let definition = $0.definition {
                    wordDefinitions.append(definition)
                }
            }
        }
        
        return wordDefinitions
    }
    
    private func getWordsWithout(exceptionWord: Word) -> [Word] {
        var allWordsWithoutExceptionWord = self.words
        if let wordIndex = allWordsWithoutExceptionWord.firstIndex(of: exceptionWord) {
            allWordsWithoutExceptionWord.remove(at: wordIndex)
        }
        
        let placeholder1 = Word(word: "Cooking",
                                phonetics: nil,
                                meanings: nil,
                                phonetic: nil)
        let placeholder2 = Word(word: "Smiling",
                                phonetics: nil,
                                meanings: nil,
                                phonetic: nil)
        let placeholder3 = Word(word: "Freezing",
                                phonetics: nil,
                                meanings: nil,
                                phonetic: nil)
        
        if allWordsWithoutExceptionWord.count == 0 {
            return []
        } else if allWordsWithoutExceptionWord.count == 1 {
            return allWordsWithoutExceptionWord
        }
        
        var words: [Word] = []
        while words.count < 3 {
            if
                let word = allWordsWithoutExceptionWord.randomElement(),
                let wordIndex = allWordsWithoutExceptionWord.firstIndex(of: word)
            {
                words.append(word)
                allWordsWithoutExceptionWord.remove(at: wordIndex)
            }
        }
        
        return words
    }
}
