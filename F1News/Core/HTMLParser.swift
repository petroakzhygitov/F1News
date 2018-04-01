import Foundation
import SwiftSoup

class HTMLParser {
    
    let urlString: String
    var title: String = ""
    var text: String = ""
    
    
    init(urlString: String){
       
        self.urlString = urlString
    }
    
    func parse(){
        
        guard let myURL = URL(string: self.urlString) else {
            print("Error: \(self.urlString) doesn't seem to be a valid URL")
            return
        }
        do {
            
            let html = try String(contentsOf: myURL, encoding: .utf8)
            do {
            
                let doc: Document = try! SwiftSoup.parse(html)
                let titleText = try! doc.select("h1")
                self.title = try! titleText.text()
                
                let paragraphs = try! doc.select("p")
                for paragraph in paragraphs {
                    
                    self.text += try! paragraph.text()
                }
            } catch Exception.Error( _, let message) {
                print(message)
            } catch {
                print("error")
            }
            
        } catch let error {
            print("Error: \(error)")
        }
    }
    
}
