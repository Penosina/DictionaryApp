import UIKit

public enum CountdownItem {
    case five, four, three, two, one, go
    
    var title: String {
        switch self {
        case .five:
            return "5"
        case .four:
            return "4"
        case .three:
            return "3"
        case .two:
            return "2"
        case .one:
            return "1"
        case .go:
            return "GO!"
        }
    }
    
    var color: UIColor? {
        switch self {
        case .five, .go:
            return R.color.orange()
        case .four:
            return R.color.lightBlue()
        case .three:
            return R.color.green()
        case .two:
            return R.color.yellow()
        case .one:
            return R.color.red()
        }
    }
    
    var animationColor: UIColor? {
        self == .go ? .clear : color
    }
}
