import UIKit

class OnboardingViewController: BaseViewController {
    // MARK: - Properties
    private let skipButton = UIButton()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private let pageControl = BasePageControl()
    private let nextButton = OrangeRoundedButton()
    private let viewModel: OnboardingViewModel
    
    // MARK: - Actions
    @objc private func skipOnboardingScene() {
        viewModel.showRegistrationScene()
    }
    
    @objc private func showNextPageOrNextScene() {
        viewModel.showNextPageOrNextScene()
    }
    
    // MARK: - Init
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToViewModel()
        viewModel.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(skipButton)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        setupSkipButton()
        setupCollectionView()
        setupPageControl()
        setupNextButton()
    }
    
    private func setupSkipButton() {
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.standart)
            make.trailing.equalToSuperview().inset(Dimensions.standart)
        }
        
        skipButton.titleLabel?.font = R.font.rubikMedium(size: Dimensions.subtitle) 
        skipButton.setTitleColor(R.color.gray(), for: .normal)
        skipButton.setTitle(R.string.localizable.skip(), for: .normal)
        skipButton.addTarget(self, action: #selector(skipOnboardingScene), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(collectionView.snp.width).multipliedBy(Dimensions.collectionViewAspectRatio)
        }
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(OnboardingCellView.self, forCellWithReuseIdentifier: Strings.reuseIdentifier)
    }
    
    private func setupPageControl() {
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(Dimensions.standart)
            make.centerX.equalToSuperview()
        }
        
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = R.color.lightBlue()
        pageControl.pageIndicatorTintColor = R.color.lightGray()
        pageControl.isUserInteractionEnabled = false
    }
    
    private func setupNextButton() {
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.large)
            make.height.equalTo(Dimensions.standartHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.standart)
        }
        
        nextButton.configure(withTitle: R.string.localizable.next())
        nextButton.addTarget(self, action: #selector(showNextPageOrNextScene), for: .touchUpInside)
    }
    
    private func bindToViewModel() {
        viewModel.didSetDelegates = { [weak self] in
            self?.collectionView.delegate = self
            self?.collectionView.dataSource = self
        }
        
        viewModel.didUpdatePageControl = { [weak self] currentPage in
            self?.pageControl.currentPage = currentPage
        }
        
        viewModel.didUpdateNextButtonTitle = { [weak self] buttonTitle in
            self?.nextButton.setTitle(buttonTitle, for: .normal)
        }
        
        viewModel.didShowNextPage = { [weak self] indexPath in
            self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.reuseIdentifier, for: indexPath) as? OnboardingCellView else {
            return UICollectionViewCell()
        }
        
        do {
            try cell.configure(with: viewModel.getCellViewModel(atIndex: indexPath.row))
        } catch {
            showError(error)
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        let currentPage = Int(scrollView.contentOffset.x / width)
        viewModel.updatePage(currentPage: currentPage)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

// MARK: - Strings
private extension Strings {
    static let reuseIdentifier = String(describing: OnboardingCellView.self)
}

// MARK: - Dimensions
private extension Dimensions {
    static let collectionViewAspectRatio = 1.12
}
