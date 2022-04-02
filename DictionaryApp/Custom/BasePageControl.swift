import UIKit

class BasePageControl: UIPageControl {
    // MARK: - Properties
    var currentPageImage: UIImage? = R.image.currentPageImage()
    var otherPagesImage: UIImage? = R.image.otherPagesImage()

    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }

    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
        } else {
            pageIndicatorTintColor = .clear
            currentPageIndicatorTintColor = .clear
            clipsToBounds = false
        }
    }

    // MARK: - Private Methods
    private func defaultConfigurationForiOS14AndAbove() {
        if #available(iOS 14.0, *) {
            for index in 0..<numberOfPages {
                let image = index == currentPage ? currentPageImage : otherPagesImage
                setIndicatorImage(image, forPage: index)
            }
        }
    }

    private func updateDots() {
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
        } else {
            for (index, subview) in subviews.enumerated() {
                let imageView: UIImageView
                if let existingImageview = getImageView(forSubview: subview) {
                    imageView = existingImageview
                } else {
                    imageView = UIImageView(image: otherPagesImage)
                    imageView.center = subview.center
                    subview.addSubview(imageView)
                    subview.clipsToBounds = false
                }
                
                imageView.image = currentPage == index ? currentPageImage : otherPagesImage
            }
        }
    }

    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        }
        
        return view.subviews.first { $0 is UIImageView } as? UIImageView
    }
}
