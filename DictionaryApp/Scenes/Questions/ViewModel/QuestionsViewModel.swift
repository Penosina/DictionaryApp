final class QuestionsViewModel {
    // MARK: - Properties
    var didUpdateData: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    var trainingTasks: [TrainingTask] = []
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func start() {
        compileTest()
    }
    
    // MARK: - Private Methods
    private func compileTest() {
        dependencies.wordsRepository.getAll { [weak self] words in
            let testCompiler = TestCompiler(words: words)
            let testCompilationResult = testCompiler.compileTest()
            switch testCompilationResult {
            case .success(let tasks):
                self?.trainingTasks = tasks
            case .failure(let error):
                self?.didReceiveError?(error)
            }
        } onError: { [weak self] error in
            self?.didReceiveError?(error)
        }
    }
}
