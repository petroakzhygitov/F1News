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
            let data =  self.getFormatedDateTime(sqlDate: dataString).data(using: .utf8)!
            
            let parser: NewsDataXMLParser = NewsDataXMLParser()
            let newsDataItems: Array<NewsDataItem> = parser.parse(data: data)
            completion(newsDataItems, nil)
        }
    }
    
     func getFormatedDateTime(sqlDate: String?) -> String {
        
        if (sqlDate == nil || sqlDate == "") {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        let date = dateFormatter.date(from: sqlDate!)
        
        let localFormatter = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd HH-mm", options: 0, locale: NSLocale.current)
        
        dateFormatter.dateFormat = localFormatter
        
        
        let outputDate = dateFormatter.string(from: date!)
        
        return outputDate
    }

}
