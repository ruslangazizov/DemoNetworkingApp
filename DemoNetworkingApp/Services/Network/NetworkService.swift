//
//  NetworkService.swift
//  DemoNetworkingApp
//
//  Created by r.a.gazizov on 04.05.2023.
//

import Foundation
import Alamofire

protocol INetworkService: AnyObject {
    func getCharacters(page: Int, completion: @escaping ([Character]) -> Void)
}

final class NetworkService: INetworkService {
    
    private let apiBase = "https://rickandmortyapi.com/api/"
    
    func getCharacters(page: Int, completion: @escaping ([Character]) -> Void) {
        let params: [String: Any] = ["page": page] // здесь можно задавать любые query string параметры
        let request = AF.request(apiBase + "character", parameters: params)
        
        request.responseDecodable(of: APIResponse<[Character]>.self) { dataResponse in
            let response: APIResponse<[Character]>? = dataResponse.value
            
            completion(response?.content ?? [])
        }
    }
}
