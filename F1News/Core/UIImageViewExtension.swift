import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func downloadAndSet(imageUrl: URL) {
        
        self.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "placeholderImage"), options: [.progressiveDownload, .continueInBackground], completed: nil)
    } 
}
