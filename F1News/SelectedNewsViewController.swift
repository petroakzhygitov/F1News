import UIKit
import WebKit

class SelectedNewsViewController: UIViewController {
    

    @IBOutlet weak var webView: WKWebView!
    
    var selectedNewsViewVM: ArticleViewVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(selectedNewsViewVM.urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
