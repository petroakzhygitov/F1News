import Foundation

class ArticleViewVM {
    
    public var newsDataItem: NewsDataItem
    public var htmlParser: HTMLParser
    public var urlRequest : URLRequest
    
    init(newsDataItem: NewsDataItem){
        self.newsDataItem = newsDataItem
        self.htmlParser = HTMLParser(urlString: newsDataItem.link)
        htmlParser.parse()
        self.urlRequest = URLRequest(url: URL.init(string: newsDataItem.link)!)
    }
}
