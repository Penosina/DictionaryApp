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
    private let meaningsStackView = UIStackView()
    private var viewModel: WordViewModel?
    
    // MARK: - Actions
    @objc private func playSound() {
        viewModel?.playSound()
    }
    
    // MARK: - Configuration
    func configure(with viewModel: WordViewModel?) {
        setup()
        
        self.viewModel = viewModel
        bindToViewModel()
        self.viewModel?.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        backgroundColor = .clear
        
        addSubview(firstStackView)
        firstStackView.addArrangedSubview(wordLabel)
        firstStackView.addArrangedSubview(wordTranscriptionLabel)
        firstStackView.addArrangedSubview(volumeImageView)
        addSubview(secondStackView)
        secondStackView.addArrangedSubview(partOfSpeechLabel)
        secondStackView.addArrangedSubview(partOfSpeechValueLabel)
        addSubview(meaningsLabel)
        addSubview(meaningsStackView)
        
        setupFirstStackView()
        setupWordLabel()
        setupWordTranscriptionLabel()
        setupVolumeImageView()
        setupSecondStackView()
        setupPartOfSpeechLabel()
        setupPartOfSpeechValueLabel()
        setupMeaningsLabel()
        setupMeaningsStackView()
    }
    
    private func setupFirstStackView() {
        firstStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Dimensions.standart)
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
        volumeImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(playSound))
        volumeImageView.addGestureRecognizer(tapGesture)
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
        partOfSpeechLabel.font = UIFont.rubik(.medium, size: Dimensions.premedium)
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
        
        meaningsLabel.font = UIFont.rubik(.medium, size: Dimensions.premedium)
        meaningsLabel.textColor = .black
        meaningsLabel.text = "Meanings:"
    }
    
    private func setupMeaningsStackView() {
        meaningsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(meaningsLabel.snp.bottom).offset(Dimensions.standartSpacing)
            make.bottom.equalToSuperview().inset(Dimensions.bottomStackViewConstraint)
        }
        
        meaningsStackView.axis = .vertical
        meaningsStackView.spacing = Dimensions.standartSpacing
    }

    private func bindToViewModel() {
        viewModel?.didUpdateData = { [weak self] in
            self?.meaningsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            self?.wordLabel.text = self?.viewModel?.wordString
            self?.wordTranscriptionLabel.text = self?.viewModel?.wordTranscription
            self?.partOfSpeechValueLabel.text = self?.viewModel?.partOfSpeech
            self?.viewModel?.meaningsViewModels.forEach { meaningViewModel in
                self?.meaningsStackView.addArrangedSubview(
                    MeaningView(viewModel: meaningViewModel)
                )
            }
        }
        
        viewModel?.didHideVolumeImage = { [weak self] in
            self?.volumeImageView.isHidden = true
        }
        
        viewModel?.didShowVolumeImage = { [weak self] in
            self?.volumeImageView.isHidden = false
        }
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

// MARK: - Dimensions
private extension Dimensions {
    static let bottomStackViewConstraint = 88.0
    static let premedium = 20.0
}
