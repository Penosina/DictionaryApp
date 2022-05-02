final class CountdownItemIterator: IteratorProtocol {
    // MARK: - Properties
    private let items: [CountdownItem]
    private var current = 0
    
    // MARK: - Init
    init(items: [CountdownItem]) {
        self.items = items
    }
    
    // MARK: - next()
    func next() -> CountdownItem? {
        defer { current += 1 }
        return items.count > current ? items[current] : nil
    }
}
