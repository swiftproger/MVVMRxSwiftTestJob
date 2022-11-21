//
//  ReceiveImage.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 16.11.2022.
//

import Foundation
import UIKit

final class ReceiveImage {

    private init() {}

    static var shared = ReceiveImage()

    private var imageCache = NSCache<NSString, UIImage>()

    public func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {

        guard let url = URL(string: urlString) else { return }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard error == nil,
                      data != nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let self = self else {
                    return
                }
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
}
