import Foundation

class NewsDataXMLParser: NSObject, XMLParserDelegate {

    private var parsingNewItem: Bool = false

    private var parsingElement: Bool = false
    private var parsingElementName: String = ""

    private var newsItems: Array<NewsDataItem> = Array<NewsDataItem>()

    private var itemTitle: String = ""
    private var itemDescription: String = ""
    private var itemLink: String = ""
    private var itemGUID: String = ""
    private var itemPublishDate: String = ""
    private var itemImageURL: String = ""

    func parse(data: Data) -> Array<NewsDataItem> {
        newsItems = Array<NewsDataItem>()
        
        let xmlParser: XMLParser = XMLParser.init(data: data)
        xmlParser.delegate = self
        xmlParser.parse()

        return newsItems
    }

    //XMLParser Methods

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        startParsingElement(elementName)

        if elementName == "item" {
            startParsingNewItem()

        } else if elementName == "enclosure" {
            parseImageURL(attributeDict: attributeDict)
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        stopParsingElement(elementName)

        if elementName == "item" {
            stopParsingNewItem()
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if parsingNewItem && parsingElement {
            setElementValue(value: string)
        }
    }

    private func setElementValue(value: String) {
        switch (parsingElementName) {
            case "title":
                itemTitle = value
                break

            case "description":
                itemDescription = value
                break

            case "link":
                itemLink = value
                break

            case "guid":
                itemGUID = value
                break

            case "pubDate":
                itemPublishDate = value
                break
        
            default:
                break
        }
    }

    private func parseImageURL(attributeDict: [String: String]) {
        itemImageURL = attributeDict["url"] ?? ""
    }

    private func startParsingElement(_ elementName: String) {
        parsingElementName = elementName
        parsingElement = true
    }

    private func stopParsingElement(_ elementName: String) {
        parsingElementName = ""
        parsingElement = false
    }

    private func startParsingNewItem() {
        clearNewItemProperties()

        parsingNewItem = true
    }

    private func stopParsingNewItem() {
        parsingNewItem = false

        appendNewItem()
    }

    private func clearNewItemProperties() {
        itemGUID = ""
        itemDescription = ""
        itemTitle = ""
        itemLink = ""
        itemPublishDate = ""
        itemImageURL = ""
    }

    private func appendNewItem() {
        let newItem = createNewDataItem()

        newsItems.append(newItem)
    }

    private func createNewDataItem() -> NewsDataItem {
        return NewsDataItem(id: itemGUID,
                description: itemDescription,
                title: itemTitle,
                link: itemLink,
                publishedDate: itemPublishDate,
                imageURL: itemImageURL)
    }
}
