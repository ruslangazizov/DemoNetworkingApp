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
    
    func getCharacters(page: Int, completion: @escaping ([Character]) -> Void) {
        let request = AF.request("https://rickandmortyapi.com/api/character", parameters: ["page": page])
        
        request.responseDecodable(of: APIResponse<[Character]>.self) { dataResponse in
            let response: APIResponse<[Character]>? = dataResponse.value
            
            completion(response?.content ?? [])
        }
    }
}
