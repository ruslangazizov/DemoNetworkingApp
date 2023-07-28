//
//  ImageDownloadManager.swift
//  DemoNetworkingApp
//
//  Created by Руслан on 28.07.2023.
//

import UIKit

final class ImageDownloadManager {

    // Dependencies
    private let cacheManager: ICacheManager

    // Properties
    private var task: URLSessionDataTask?

    // MARK: - Initialization

    init(cacheManager: ICacheManager) {
        self.cacheManager = cacheManager
    }

    // MARK: - Internal

    func downloadImage(withUrl urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cacheManager.getImage(forKey: urlString) {
            completion(image)
            return
        }

        guard let url = URL(string: urlString) else { completion(nil); return }

        task?.cancel()
        task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            DispatchQueue.main.async {
                guard error == nil, let data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }

                self?.cacheManager.setImage(image, forKey: urlString)
                completion(image)
            }
        }
        task?.resume()
    }
}
