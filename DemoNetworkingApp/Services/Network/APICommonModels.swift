//
//  APICommonModels.swift
//  DemoNetworkingApp
//
//  Created by r.a.gazizov on 04.05.2023.
//

import Foundation

struct APIResponse<ContentModel: Decodable>: Decodable {
    let info: APIInfo
    let content: ContentModel
    
    enum CodingKeys: String, CodingKey {
        case info
        case content = "results"
    }
}

struct APIInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
