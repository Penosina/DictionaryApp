import Alamofire

final class NetworkManager {
    // MARK: - Properties
    private let baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    // MARK: - Public Methods
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
}
