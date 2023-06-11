//
//  ServiceAPIProtocol.swift
//  MovieApp
//
//  Created by Марина Рябчун on 09.06.2023.
//

import Foundation

protocol ServiceAPIProtocol {
    func fetchData(url: URL?, completion: @escaping(Result<SearchResponse, APIError>) -> Void)
}
