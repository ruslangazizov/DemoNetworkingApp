//
//  UIImageView+Extensions.swift
//  DemoNetworkingApp
//
//  Created by r.a.gazizov on 04.05.2023.
//

import UIKit
import SnapKit

extension UIImageView {
    
    func downloadImage(from urlString: String) {
        CacheManager.shared.image(forUrl: urlString) { [weak self] (image: UIImage?) in
            self?.image = image
        }
    }
}
