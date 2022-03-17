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
        tabBar.layer.borderColor = Colors.textFieldBorder?.cgColor
        tabBar.layer.cornerRadius = Dimensions.standart
        tabBar.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMinYCorner
        ]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let kBarHeight = Dimensions.standartHeight + 10
        tabBar.frame.size.height = kBarHeight
        tabBar.frame.origin.y = view.frame.height - kBarHeight
    }
    
    // MARK: - Private Methods
    private func setup() {
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = .clear
        tabBar.tintColor = Colors.orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
