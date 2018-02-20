//
//  NewsDataWebServiceTests.swift
//  F1NewsTests
//
//  Created by Ievgeniia Bondini on 2/20/18.
//  Copyright © 2018 Petro Akzhygitov. All rights reserved.
//

import XCTest
@testable import F1News


class NewsDataWebServiceTests: XCTestCase {
    
    func test_loadNewsData_should_return_newsItems(){
        //arrange
        let newWebService =  NewsDataWebService(webService: WebServiceMock())
        
        //act
        newWebService.loadNewsData { newItems, error in
            //assert
            XCTAssert(newItems.count == 1)
        }
    }
    
    func test_loadNewsData_should_pass_correct_url(){
        //arrange
        let webService = WebServiceMock()
        let newWebService =  NewsDataWebService(webService: webService)
        
        //act
        newWebService.loadNewsData { newItems, error in
            //assert
            XCTAssert(webService.url == RSSPath.newsRU.rawValue)
        }
    }
}


class WebServiceMock: WebService{
    let dataString = """
        <item>
        <title>Технические характеристики Renault R.S.18</title>
        <description>
        Пресс-служба Renault опубликовала технические характеристики машины 2018 года...
        </description>
        <link>https://www.f1news.ru/news/f1-127004.html</link>
        <guid>http://www.f1news.ru/news/f1-127004.html</guid>
        <pubDate>Tue, 20 Feb 2018 21:17:00 +0300</pubDate>
        <enclosure url=\"https://cdn.f1ne.ws/userfiles/renault/127004.jpg\" type=\"image/jpeg\" length=\"0\"/>
        </item>
    """
    
    var url = ""
    
    override func downLoadString(url: URL, _ completion: @escaping (String, Error?) -> Void) {
        self.url =  url.absoluteString
        completion(dataString, nil)
    }
}

