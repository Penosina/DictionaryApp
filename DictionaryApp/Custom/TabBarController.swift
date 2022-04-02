import UIKit

class TabBarController: UITabBarController {
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = R.color.textFieldBorder()?.cgColor
        tabBar.layer.cornerRadius = Dimensions.standart
        tabBar.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMinYCorner
        ]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.frame.size.height = Dimensions.tabBarHeight
        tabBar.frame.origin.y = view.frame.height - Dimensions.tabBarHeight
    }
    
    // MARK: - Private Methods
    private func setup() {
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = .clear
        tabBar.tintColor = R.color.orange()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Dimensions
private extension Dimensions {
    /// 66.0
    static let tabBarHeight = 66.0
}
