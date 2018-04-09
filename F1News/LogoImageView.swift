import Foundation
import UIKit

class LogoImageView: UIImageView {
    
    private enum Constants {
        static let LogoImageName = "f1news.png"
    }

    private let logoImage = UIImage(named: Constants.LogoImageName)
    
    init() {
        super.init(image: logoImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        image = logoImage
    }
}
