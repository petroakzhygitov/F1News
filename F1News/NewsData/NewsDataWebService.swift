import Foundation

fileprivate enum Endpoints {
    case FoodData
}

fileprivate extension Endpoints {
    static let apiURL = "https://www.f1news.ru/export/news.xml"

    var path: String {
        switch self {
        case .FoodData: return "placedata"
        }
    }

    var url: URL {
        return URL(string: Endpoints.apiURL + self.path)!
    }
}

class NewsDataWebService {
    private var dataLoader: DataLoader

    convenience init() {
        self.init(dataLoader: URLSessionDataLoader())
    }

    init(dataLoader: DataLoader) {
        self.dataLoader = dataLoader
    }

    func loadNewsData(completion: @escaping (Array<NewDataItem>, Error?) -> ()) {
        dataLoader.loadNewsData(with: Endpoints.FoodData.url) { data, _, error in
            guard let data = data, error == nil else {
                completion([], error)

                return
            }

            let urlPath = Bundle.main.path(forResource: "news", ofType: "xml")
            let url = URL.init(fileURLWithPath: urlPath!)

            let parser: NewsDataXMLParser = NewsDataXMLParser()
            do {
                let data: Data = try Data.init(contentsOf: url)
                let newsDataItems: Array<NewDataItem> = parser.parse(data: data)

                completion(newsDataItems, nil)
                
            } catch {
                completion(Array<NewDataItem>(), nil)
            }
        }
    }
}
