import Foundation

// MARK: - WordViewModelDelegate
protocol WordViewModelDelegate: AnyObject {
    func playSound(audioURL: URL)
}

final class WordViewModel {
    // MARK: - Properties
    var meaningsViewModels: [MeaningViewModel] = []
    var countOfMeanings: Int {
        meaningsViewModels.count
    }
    
    weak var delegate: WordViewModelDelegate?
    
    let word: Word
    var wordString: String?
    var wordTranscription: String?
    var partOfSpeech: String?
    
    var didUpdateData: (() -> Void)?
    var didHideVolumeImage: (() -> Void)?
    var didShowVolumeImage: (() -> Void)?
    
    private var meanings: [Definition]?
    private var audioURL: URL?
    
    // MARK: - Init
    init(word: Word) {
        self.word = word
        
        audioURL = word.phonetics?.first?.audioURL
        wordString = word.word
        wordTranscription = word.phoneticString
        partOfSpeech = word.meanings?.first?.partOfSpeech
        meanings = word.meanings?.first?.definitions
        setCellViewModels()
    }
    
    // MARK: - Public Methods
    func start() {
        didUpdateData?()
        
        if audioURL == nil {
            didHideVolumeImage?()
        } else {
            didShowVolumeImage?()
        }
    }
    
    func getCellViewModel(index: Int) throws -> MeaningViewModel {
        guard index < meaningsViewModels.count else {
            throw Errors.indexOutOfRange
        }
        
        return meaningsViewModels[index]
    }
    
    func playSound() {
        guard let audioURL = audioURL else {
            return
        }

        delegate?.playSound(audioURL: audioURL)
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
