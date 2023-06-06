//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Марина Рябчун on 04.06.2023.
//

import Foundation

protocol MovieListViewModelProtocol {
    var users: Observable<[CellViewModel]> { get }
    func fetchData(_ searchBarText: String)
}

struct MovieListViewModel: MovieListViewModelProtocol {
    var users: Observable<[CellViewModel]> = Observable([])
    
    func fetchData(_ searchBarText: String) {
        guard let url = URL(string: "https://imdb-api.com/API/AdvancedSearch/k_piw286ze/?title=\(searchBarText)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let userModel = try JSONDecoder().decode(SearchResponse.self, from: data)
                users.value = userModel.results.compactMap({
                    CellViewModel(image: $0.image, title: $0.title,
                                  description: $0.description, imDbRating: $0.imDbRating,
                                  imDbRatingVotes: $0.imDbRatingVotes, genres: $0.genres,
                                  runtimeStr: $0.runtimeStr, stars: $0.stars, plot: $0.plot)
                })
            } catch {
            }
        }
        task.resume()
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

