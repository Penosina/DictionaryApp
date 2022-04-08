import Alamofire

final class APIService: DictionaryDataSource {
    
    // MARK: - Properties
    private let baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    private static let reachibilityManager = NetworkReachabilityManager(host: "https://api.dictionaryapi.dev")
      
    // MARK: - Public Methods
    static func isConnected() -> Bool {
        reachibilityManager?.isReachable ?? false
    }
    
    func find(word: String,
              _ onComplete: @escaping (Word) -> Void,
              onError: @escaping (Error, Int) -> Void) {
        AF.request(baseURL + word,
                   method: .get)
            .validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let decodedData = try? JSONDecoder().decode([Word].self,
                                                               from: data),
                   let wordModel = decodedData.first {
                    onComplete(wordModel)
                } else {
                    print(String(data: data, encoding: .utf8) as Any)
                }
            case .failure(let error):
                onError(error, response.response?.statusCode ?? 500)
            }
        }
    }
    
    func get(word: String,
             _ onComplete: @escaping (Word) -> Void,
             onError: @escaping (Error) -> Void) {
        AF.request(baseURL + word,
                   method: .get)
            .validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let decodedData = try? JSONDecoder().decode([Word].self,
                                                               from: data),
                   let wordModel = decodedData.first {
                    onComplete(wordModel)
                } else {
                    print(String(data: data, encoding: .utf8) as Any)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func addToRepository(word: Word) -> Void { }
    
    func getAll(_ onComplete: @escaping ([Word]) -> Void,
                onError: @escaping (Error) -> Void) { }
}
