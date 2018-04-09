import Foundation

class NewsDataWebService {
    private var webService: WebService

    convenience init() {
        self.init(webService: WebService())
    }

    init(webService: WebService) {
        self.webService = webService
    }

    func loadNewsData(completion: @escaping (Array<NewsDataItem>, Error?) -> ()) {
        let url = URL(string:RSSPath.newsRU.rawValue)!
        self.webService.downLoadString(url: url) { dataString, error in
            guard error == nil else {
                return completion([], error)
            }
            let data = dataString.data(using: .utf8)!
            
            let parser: ArticlesXMLParser = ArticlesXMLParser()
            let newsDataItems: Array<NewsDataItem> = parser.parse(data: data)
            completion(newsDataItems, nil)
        }
    }
}
