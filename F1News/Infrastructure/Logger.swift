import Foundation
import SwiftyBeaver


class Logger {
    static func set(){
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file
        
        print("File for logging", file.logFileURL ?? "")
        console.format = "$DHH:mm:ss$d $L $M"
        SwiftyBeaver.addDestination(console)
        SwiftyBeaver.addDestination(file)
    }
    
    static func verbose(_ message: String){
        SwiftyBeaver.verbose(message) // prio 1, VERBOSE in silver
    }
    
    static func debug(_ message: String){
        SwiftyBeaver.debug(message) // prio 2, DEBUG in green
    }
    
    static func info(_ message: String){
        SwiftyBeaver.info(message) // prio 3, INFO in blue
    }
    
    static func warning(_ message: String){
        SwiftyBeaver.warning(message)  // prio 4, WARNING in yellow
    }
    
    static func error(_ message: String){
        SwiftyBeaver.error(message)  // prio 5, ERROR in red
    }
}
