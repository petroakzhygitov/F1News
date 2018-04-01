import Foundation

class WebService {

    func downLoadString(url: URL, _ completion: @escaping (String, Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let htmlSource = try String(contentsOf: url, encoding: String.Encoding.utf8)
                completion(htmlSource, nil)
            }
            catch let error as NSError {
                
                completion("", error)
                print("Error took place while downloading a file. Error description: \(error)")
            }
        }
    }
}
