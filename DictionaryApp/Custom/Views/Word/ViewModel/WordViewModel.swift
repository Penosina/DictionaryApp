final class WordViewModel {
    // MARK: - Properties
    var countOfMeanings: Int {
        meaningsViewModels.count
    }
    
    var wordString: String?
    var wordTranscription: String?
    var partOfSpeech: String?
    var didUpdateData: (() -> Void)?
    
    private let word: Word
    private var meanings: [Definition]?
    private var meaningsViewModels: [MeaningCellViewModel] = []
    
    // MARK: - Init
    init(word: Word) {
        self.word = word
    }
    
    // MARK: - Public Methods
    func start() {
        wordString = word.word
        wordTranscription = word.phontic
        partOfSpeech = word.meanings?.first?.pertOfSpeech
        meanings = word.meanings?.first?.definitions
        setCellViewModels()
        
        didUpdateData?()
    }
    
    func getCellViewModel(index: Int) throws -> MeaningCellViewModel {
        guard index < meaningsViewModels.count else {
            throw Errors.indexOutOfRange
        }
        
        return meaningsViewModels[index]
    }
    
    // MARK: - Private Methods
    private func setCellViewModels() {
        meanings?.forEach { definition in
            meaningsViewModels.append(MeaningCellViewModel(definition: definition))
        }
    }
}
