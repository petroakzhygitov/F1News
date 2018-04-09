import Foundation

private extension String {

    var condensedWhitespace: String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}

class ArticlesXMLParser: NSObject, XMLParserDelegate {

    private enum Constants {
        static let DefaultArticlePropertyValue = ""
        
        static let NoElementName = ""

        static let ItemElementName = "item"
        static let EnclosureElementName = "enclosure"

        static let TitleElementName = "title"
        static let DescriptionElementName = "description"
        static let GUIDElementName = "guid"
        static let PubDateElementName = "pubDate"
        static let LinkElementName = "link"

        static let URLAttributeKey = "url"
    }
    
    private var isParsingArticle = false
    private var isParsingElement = false

    private var parsedElementName = ""

    private var articles = Array<NewsDataItem>()

    private var articleTitle = Constants.DefaultArticlePropertyValue
    private var articleDescription = Constants.DefaultArticlePropertyValue
    private var articleLink = Constants.DefaultArticlePropertyValue
    private var articleGUID = Constants.DefaultArticlePropertyValue
    private var articlePublishDate = Constants.DefaultArticlePropertyValue
    private var articleImageURL = Constants.DefaultArticlePropertyValue

    func parse(data: Data) -> Array<NewsDataItem> {
        articles = Array<NewsDataItem>()

        let xmlParser: XMLParser = XMLParser.init(data: data)
        xmlParser.delegate = self
        xmlParser.parse()

        return articles
    }

    // MARK: XMLParser Methods

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        startParsingElement(elementName)

        switch (elementName) {
        case Constants.ItemElementName:
            startParsingArticle()
        case Constants.EnclosureElementName:
            parseImageURL(attributeDict: attributeDict)
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        finishParsingElement(elementName)

        if elementName == Constants.ItemElementName {
            finishParsingArticle()
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isParsingArticle && isParsingElement {
            appendElementValue(value: string)
        }
    }

    private func appendElementValue(value: String) {
        let whitespacesFilteredString = value.condensedWhitespace

        switch (parsedElementName) {
            case Constants.TitleElementName:
                articleTitle += whitespacesFilteredString
            case Constants.DescriptionElementName:
                articleDescription += whitespacesFilteredString
            case Constants.LinkElementName:
                articleLink += whitespacesFilteredString
            case Constants.GUIDElementName:
                articleGUID += whitespacesFilteredString
            case Constants.PubDateElementName:
                articlePublishDate += whitespacesFilteredString
            default:
                break
        }
    }

    private func parseImageURL(attributeDict: [String: String]) {
        articleImageURL = attributeDict[Constants.URLAttributeKey] ?? ""
    }

    private func startParsingElement(_ elementName: String) {
        parsedElementName = elementName

        isParsingElement = true
    }

    private func finishParsingElement(_ elementName: String) {
        parsedElementName = Constants.NoElementName

        isParsingElement = false
    }

    private func startParsingArticle() {
        clearArticleProperties()

        isParsingArticle = true
    }

    private func finishParsingArticle() {
        isParsingArticle = false

        let article = createArticle()
        articles.append(article)
    }

    private func clearArticleProperties() {
        articleGUID = Constants.DefaultArticlePropertyValue
        articleDescription = Constants.DefaultArticlePropertyValue
        articleTitle = Constants.DefaultArticlePropertyValue
        articleLink = Constants.DefaultArticlePropertyValue
        articlePublishDate = Constants.DefaultArticlePropertyValue
        articleImageURL = Constants.DefaultArticlePropertyValue
    }
    
    private func createArticle() -> NewsDataItem {
        return NewsDataItem(id: articleGUID,
                description: articleDescription,
                title: articleTitle,
                link: articleLink,
                publishedDate: articlePublishDate,
                imageURL: articleImageURL)
    }
}
