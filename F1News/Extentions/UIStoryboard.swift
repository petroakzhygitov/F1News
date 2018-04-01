import Foundation
import UIKit

extension UIStoryboard {
    
    func instantiate<T: UIViewController>(_ type: T.Type) -> T {
        
        let controller = self.instantiateViewController(withIdentifier: String(describing: type))
        
        guard let typedController = controller as? T else {
            
            preconditionFailure("Failed to instanticate controller of type: \(type)")
        }
        return typedController;
    }
}
