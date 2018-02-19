import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func downloadImage(url: URL) {
        
        self.sd_setImage(with: url, placeholderImage:#imageLiteral(resourceName: "placeholderImage"), options: [.progressiveDownload, .continueInBackground], completed: nil)
    } 
}
