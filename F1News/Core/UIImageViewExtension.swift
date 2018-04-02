import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func downloadAndSet(imageUrl: URL) {
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(.gray)
        self.sd_setImage(with: imageUrl,
                         placeholderImage:nil,
                         options: [.progressiveDownload,
                                   .continueInBackground],
                        completed: nil)
    } 
}
