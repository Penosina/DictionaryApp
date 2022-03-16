import UIKit

// MARK: - SearchTextFieldDelegate
protocol SearchTextFieldDelegate: AnyObject {
    func search()
}

class SearchTextField: CustomTextField {
    // MARK: - Properties
    weak var searchDelegate: SearchTextFieldDelegate?
    private let imageView = UIImageView()
    
    // MARK: - Actions
    @objc private func search() {
        searchDelegate?.search()
    }
    
    // MARK: - Override setup()
    override func setup() {
        super.setup()
        
        setupImageView()
    }
    
    // MARK: - Private Methods
    private func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(Dimensions.standart)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(search))
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Images.search)
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - Images
private extension Images {
    static let search = "searchIcon"
}
