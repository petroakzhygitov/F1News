import XCTest
@testable import F1News

class ArticlesXMLParserTests: XCTestCase {

    func testParsing() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "news", ofType: "xml")!
        let url = URL.init(fileURLWithPath: path)

        do {
            let xmlData = try Data.init(contentsOf: url)

            let parser = ArticlesXMLParser()
            let articles: Array<NewsDataItem> = parser.parse(data: xmlData)

            XCTAssertEqual(articles.count, 69)

            XCTAssertEqual(articles[0].id, "http://www.f1news.ru/interview/abiteboul/126009.shtml")
            XCTAssertEqual(articles[0].title, "Сирил Абитебул: Мы действовали слишком агрессивно")
            XCTAssertEqual(articles[0].description, "Управляющий директор Renault Sport Сирил Абитебул объяснил причины проблем с моторами и говорил о перспективах заводской команды...")
            XCTAssertEqual(articles[0].link, "https://www.f1news.ru/interview/abiteboul/126009.shtml")
            XCTAssertEqual(articles[0].imageURL, "https://cdn.f1ne.ws/userfiles/abiteboul/126009.jpg")
            XCTAssertEqual(articles[0].publishedDate, "Thu, 14 Dec 2017 21:28:00 +0300")
            
            XCTAssertEqual(articles[1].id, "http://www.f1news.ru/news/f1-126012.html")
            XCTAssertEqual(articles[1].title, "Окон: Всё, что можно исправить, нужно исправить")
            XCTAssertEqual(articles[1].description, "Эстебан Окон отлично провёл первый полный сезон в Force India. УВ 2018-м молодой француз надеется на большее…")
            XCTAssertEqual(articles[1].link, "https://www.f1news.ru/news/f1-126012.html")
            XCTAssertEqual(articles[1].imageURL, "https://cdn.f1ne.ws/userfiles/ocon/124453.jpg")
            XCTAssertEqual(articles[1].publishedDate, "Thu, 14 Dec 2017 21:25:00 +0300")

        } catch {
            XCTFail()
        }
    }

}
