import Foundation

protocol DataLoader {
    func loadNewsData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void)
}

class URLSessionDataLoader: DataLoader {
    func loadNewsData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
}
