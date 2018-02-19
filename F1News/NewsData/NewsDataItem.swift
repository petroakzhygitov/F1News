import Foundation

typealias XMLDictionary = [String: String]

struct NewDataItem {
    
    let id: String
    let description: String
    let title: String
    let link: String
    let publishedDate: String
    let imageURL: String

    fileprivate let idKey = "guid"
    fileprivate let publishDateKey = "pubDate"
    fileprivate let urlKey = "url"
    fileprivate let descriptionKey = "description"
    fileprivate let titleKey = "title"
}