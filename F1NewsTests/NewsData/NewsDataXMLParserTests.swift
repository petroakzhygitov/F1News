//
//  F1NewsTests.swift
//  F1NewsTests
//
//  Created by Petro Akzhygitov on 12/12/17.
//  Copyright © 2017 Petro Akzhygitov. All rights reserved.
//

import XCTest
@testable import F1News

class NewsDataXMLParserTests: XCTestCase {

    func testParsing() {
        let urlPath = Bundle.main.path(forResource: "news", ofType: "xml")
        let url = URL.init(fileURLWithPath: urlPath!)

        let parser: NewsDataXMLParser = NewsDataXMLParser()
        do {
            let data: Data = try Data.init(contentsOf: url)
            let newsDataItems: Array<NewsDataItem> = parser.parse(data: data)

            print("News: \(newsDataItems)")
        } catch {}
    }

}
