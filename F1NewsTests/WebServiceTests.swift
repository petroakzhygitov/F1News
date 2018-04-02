import XCTest
@testable import F1News

class WebServiceTests: XCTestCase {
    
    
    func test_download_Should_return_rsponce () {
        //arrange
        let expectationItem = expectation(description: "...")
        let websevrice = WebService()
        
        //act
        let url = URL(string: "https://www.f1news.ru/export/news.xml")!
        websevrice.downLoadString(url: url){ response, error in
            print(response)
            //assert
            XCTAssert(response.range(of:"<?xml") != nil)
            XCTAssert(error == nil)
            expectationItem.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func test_download_Should_not_return_rsponce () {
        //arrange
        let expectationItem = expectation(description: "...")
        let websevrice = WebService()
        
        //act
        let wrongUrl = URL(string: "https://www.f1news.ru/export/wrongUrl.xml")!
        websevrice.downLoadString(url: wrongUrl){ response, error in
            
            //assert
            XCTAssert(response == "")
            XCTAssert(error != nil)
            expectationItem.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
