import Foundation

class ArticleViewVM {
    
    public var newsDataItem: NewsDataItem
    public var urlRequest : URLRequest
    
    init(newsDataItem: NewsDataItem){
        self.newsDataItem = newsDataItem
        self.urlRequest = URLRequest(url: URL.init(string: newsDataItem.link)!)
    }
}
