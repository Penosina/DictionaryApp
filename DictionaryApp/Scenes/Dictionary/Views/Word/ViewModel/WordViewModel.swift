final class WordViewModel {
    // MARK: - Properties
    var meaningsViewModels: [MeaningViewModel] = []
    var countOfMeanings: Int {
        meaningsViewModels.count
    }
    
    var wordString: String?
    var wordTranscription: String?
    var partOfSpeech: String?
    var didUpdateData: (() -> Void)?
    
    private let word: Word
    private var meanings: [Definition]?
    
    // MARK: - Init
    init(word: Word) {
        self.word = word
    }
    
    // MARK: - Public Methods
    func start() {
        wordString = word.word
        wordTranscription = word.phonetic
        partOfSpeech = word.meanings?.first?.partOfSpeech
        meanings = word.meanings?.first?.definitions
        setCellViewModels()
        
        didUpdateData?()
    }
    
    func getCellViewModel(index: Int) throws -> MeaningViewModel {
        guard index < meaningsViewModels.count else {
            throw Errors.indexOutOfRange
        }
        
        return meaningsViewModels[index]
    }
    
    func playSound() {
        
    }
    
    // MARK: - Private Methods
    private func setCellViewModels() {
        meaningsViewModels = []
        meanings?.forEach { meaning in
            let meaningCellViewModel = MeaningViewModel(definition: meaning)
            meaningsViewModels.append(meaningCellViewModel)
        }
    }
}
