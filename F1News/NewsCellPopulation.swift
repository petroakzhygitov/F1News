import Foundation
import UIKit

class NewsCellPopulation {
    
    func populate(cell: UITableViewCell, newDataItem: NewsDataItem)  {
        if let newCell = cell as? NewViewCell {
            newCell.titleLabel?.text = newDataItem.title
            newCell.descriptionLabel?.text = newDataItem.description
            newCell.publishedDateLabel?.text =  getFormatedDateTime(sqlDate: newDataItem.publishedDate)
            
            newCell.imgView?.sd_cancelCurrentImageLoad()
            if let url = URL(string: newDataItem.imageURL) {
                newCell.imgView?.downloadAndSet(imageUrl: url)
            }
        }
    }
    
    func getFormatedDateTime(sqlDate: String?) -> String {
        
        if (sqlDate == nil || sqlDate == "") {
            return ""
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ssZ"
        let date = dateFormatter.date(from: sqlDate!)

        let localFormatter = DateFormatter.dateFormat(fromTemplate: "EEE, dd MMM yyyy HH:mm", options: 0, locale: NSLocale.current)
        dateFormatter.dateFormat = localFormatter
        let outputDate = dateFormatter.string(from: date!)

        return outputDate
    }
    
}

