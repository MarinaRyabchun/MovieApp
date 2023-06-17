//
//  APIMockService.swift
//  MovieApp
//
//  Created by Марина Рябчун on 16.06.2023.
//

import Foundation

struct APIMockService: ServiceAPIProtocol {
    
    var result: Result<SearchResponse, APIError>
    
    func fetchData(url: URL?, completion: @escaping (Result<SearchResponse, APIError>) -> Void) {
        completion(result)
    }
}
