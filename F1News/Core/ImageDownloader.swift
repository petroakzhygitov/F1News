//
// Created by Petro Akzhygitov on 11/02/18.
// Copyright (c) 2018 Petro Akzhygitov. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {

    fileprivate let maxConcurrentDownloads: Int

    init(maxConcurrentDownloads: Int = 0) {
        self.maxConcurrentDownloads = maxConcurrentDownloads
    }

    public func downloadImage(url: URL, completion: @escaping (UIImage?, Error?) -> ()) {
//        addImageToImageQueue(url: url, competion: completion)
//        processImageQueue()

        print("Download Started")
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in

            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")

            let image: UIImage?

            if let data = data {
                image = UIImage(data: data)
            } else {
                image = nil
            }

            completion(image, error)
            
        }.resume()
    }

    func processImageQueue() {
        
    }
}