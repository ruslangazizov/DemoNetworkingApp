//
//  ImageDownloadManager.swift
//  DemoNetworkingApp
//
//  Created by Руслан on 28.07.2023.
//

import Foundation
import Alamofire

final class ImageDownloadManager {

    // Dependencies
    private let cacheManager: ICacheManager

    // Properties
    private var request: DownloadRequest?

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

        request?.cancel()
        request = AF.download(urlString).responseData { [weak self] response in
            guard let data: Data = response.value,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self?.cacheManager.setImage(image, forKey: urlString)
            completion(image)
        }
    }
}
