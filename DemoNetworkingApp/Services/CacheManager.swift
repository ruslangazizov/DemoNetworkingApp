//
//  CacheManager.swift
//  DemoNetworkingApp
//
//  Created by r.a.gazizov on 04.05.2023.
//

import UIKit

protocol ICacheManager: AnyObject {
    func getImage(forKey key: String) -> UIImage?
    func setImage(_ image: UIImage, forKey key: String)
}

final class CacheManager: ICacheManager {

    // Properties
    private let cache = NSCache<NSString, UIImage>()

    // MARK: - Singleton

    static let shared = CacheManager()
    private init() {}

    // MARK: - ICacheManager

    func getImage(forKey key: String) -> UIImage? {
        let cacheKey = NSString(string: key)
        return cache.object(forKey: cacheKey)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        let cacheKey = NSString(string: key)
        cache.setObject(image, forKey: cacheKey)
    }
}
