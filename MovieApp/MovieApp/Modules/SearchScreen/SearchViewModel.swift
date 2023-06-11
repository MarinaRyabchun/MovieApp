//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Марина Рябчун on 04.06.2023.
//

import Foundation

protocol MovieListViewModelProtocol {
    var service: ServiceAPIProtocol { get }
    var users: Observable<[CellViewModel]> { get }
    func fetchData(_ searchBarText: String)
}

struct MovieListViewModel: MovieListViewModelProtocol {
    let service: ServiceAPIProtocol = ServiceAPI()
    var users: Observable<[CellViewModel]> = Observable([])
    
    func fetchData(_ searchBarText: String) {
        guard let url = URL(string: "https://imdb-api.com/API/AdvancedSearch/k_piw286ze/?title=\(searchBarText)") else { return }
        service.fetchData(url: url) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let movies):
                    users.value = movies.results.compactMap({
                        CellViewModel(image: $0.image, title: $0.title,
                                      description: $0.description, imDbRating: $0.imDbRating,
                                      imDbRatingVotes: $0.imDbRatingVotes, genres: $0.genres,
                                      runtimeStr: $0.runtimeStr, stars: $0.stars, plot: $0.plot)
                    })
                }
            }
        }
    }
}

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T?) {
        self.value = value
    }
    private var listener: ((T?) -> Void)?
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}

