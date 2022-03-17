import UIKit

class WordView: UIView {
    // MARK: - Properties
    private let firstStackView = UIStackView()
    private let wordLabel = UILabel()
    private let wordTranscriptionLabel = UILabel()
    private let volumeImageView = UIImageView()
    private let secondStackView = UIStackView()
    private let partOfSpeechLabel = UILabel()
    private let partOfSpeechValueLabel = UILabel()
    private let meaningsLabel = UILabel()
    private let meaningsTableView = UITableView()
    private var viewModel: WordViewModel?
    
    // MARK: - Configuration
    func configure(with viewModel: WordViewModel) {
        setup()
        
        self.viewModel = viewModel
        bindToViewModel()
        self.viewModel?.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubview(firstStackView)
        firstStackView.addSubview(wordLabel)
        firstStackView.addSubview(wordTranscriptionLabel)
        firstStackView.addSubview(volumeImageView)
        addSubview(secondStackView)
        secondStackView.addSubview(partOfSpeechLabel)
        secondStackView.addSubview(partOfSpeechValueLabel)
        addSubview(meaningsLabel)
        addSubview(meaningsTableView)
        
        setupFirstStackView()
        setupWordLabel()
        setupWordTranscriptionLabel()
        setupVolumeImageView()
        setupSecondStackView()
        setupPartOfSpeechLabel()
        setupPartOfSpeechValueLabel()
        setupMeaningsLabel()
        setupMeaningsTableView()
    }
    
    private func setupFirstStackView() {
        firstStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(Dimensions.standart)
        }
        
        firstStackView.axis = .horizontal
        firstStackView.spacing = Dimensions.standart
    }
    
    private func setupWordLabel() {
        wordLabel.font = UIFont.rubik(.medium, size: Dimensions.medium)
        wordLabel.textColor = .black
    }
    
    private func setupWordTranscriptionLabel() {
        wordTranscriptionLabel.font = UIFont.rubik(.regular, size: Dimensions.subtitle)
        wordTranscriptionLabel.textColor = Colors.orange
    }
    
    private func setupVolumeImageView() {
        volumeImageView.contentMode = .scaleAspectFit
        volumeImageView.image = UIImage(named: Images.volume)
    }
    
    private func setupSecondStackView() {
        secondStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(firstStackView.snp.bottom).offset(Dimensions.standart)
        }
        
        secondStackView.axis = .horizontal
        secondStackView.spacing = Dimensions.standart
    }
    
    private func setupPartOfSpeechLabel() {
        partOfSpeechLabel.font = UIFont.rubik(.medium, size: 20)
        partOfSpeechLabel.textColor = .black
        partOfSpeechLabel.text = "Part Of Speech:"
    }
    
    private func setupPartOfSpeechValueLabel() {
        partOfSpeechValueLabel.font = UIFont.rubik(.regular, size: Dimensions.subtitle)
        partOfSpeechLabel.textColor = .black
    }
    
    private func setupMeaningsLabel() {
        meaningsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(secondStackView.snp.bottom).offset(Dimensions.standart)
        }
        
        meaningsLabel.font = UIFont.rubik(.medium, size: 20)
        meaningsLabel.textColor = .black
        meaningsLabel.text = "Meanings:"
    }
    
    private func setupMeaningsTableView() {
        meaningsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(meaningsLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
        meaningsTableView.register(MeaningCellView.self,
                                   forCellReuseIdentifier: Strings.reuseIdentifier)
        meaningsTableView.delegate = self
        meaningsTableView.dataSource = self
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateData = { [weak self] in
            self?.wordLabel.text = self?.viewModel?.wordString
            self?.wordTranscriptionLabel.text = self?.viewModel?.wordTranscription
            self?.partOfSpeechValueLabel.text = self?.viewModel?.partOfSpeech
            self?.meaningsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension WordView: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.countOfMeanings ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.reuseIdentifier) as? MeaningCellView else {
            return UITableViewCell()
        }
        
        do {
            let cellViewModel = try viewModel?.getCellViewModel(index: indexPath.row)
            cell.configure(with: cellViewModel
                           ?? MeaningCellViewModel(definition: Definition(definition: "",
                                                                          example: "")))
        } catch {
            print(error.localizedDescription)
        }
        
        return cell
    }
}

// MARK: - Images
private extension Images {
    static let volume = "volume"
}

// MARK: - Strings
private extension Strings {
    static let reuseIdentifier = "MeaningCellView"
}
