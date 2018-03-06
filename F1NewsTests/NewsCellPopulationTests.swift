import Foundation
import UIKit
import XCTest
@testable import F1News

class NewsCellPopulationTests: XCTestCase {
    
    func test_setCell_Should_Set_Values_CellProperty() {
        //arrange
        let newsDataItem = NewDataItem(id: "tetsID", description: "testDescription", title: "testTitle", link: "teslLink", publishedDate: "testPublishedDate", imageURL: "test")
        
        let cell = NewViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellIdentifier")
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        let publishedDateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        
        cell.titleLabel = titleLabel
        cell.descriptionLabel = descriptionLabel
        cell.publishedDateLabel = publishedDateLabel
        
        let cellPopulation = NewsCellPopulation()
        
        //act
        cellPopulation.populate(cell: cell, newDataItem: newsDataItem)
        
        //assert
        assert(cell.titleLabel.text == "testTitle")
        assert(cell.descriptionLabel.text == "testDescription")
        assert(cell.publishedDateLabel.text == "testPublishedDate")
    }
    
}
