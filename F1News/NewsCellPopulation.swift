import Foundation
import UIKit

class NewsCellPopulation {
    
    func populate(cell: UITableViewCell, newDataItem: NewDataItem)  {
        if let newCell = cell as? NewViewCell {
            newCell.titleLabel?.text = newDataItem.title
            newCell.descriptionLabel?.text = newDataItem.description
            newCell.publishedDateLabel?.text = newDataItem.publishedDate
            
            if let url = URL(string: newDataItem.imageURL) {
                newCell.imgView?.downloadAndSet(imageUrl: url)
            }
        }
    }
    
}

