//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Марина Рябчун on 04.06.2023.
//

import Foundation
import UIKit

protocol SearchViewModelProtocol {
    var service: ServiceAPIProtocol { get }
    var users: Observable<[CellViewModel]> { get }
    func fetchData(_ searchBarText: String)
}

struct SearchViewModel: SearchViewModelProtocol {
    var service: ServiceAPIProtocol = ServiceAPI()
    var users: Observable<[CellViewModel]> = Observable([])
    
    func fetchData(_ searchBarText: String) {
        guard let url = URL(string: "https://imdb-api.com/API/AdvancedSearch/k_piw286ze/?title=\(searchBarText)") else {
            showAlert(message: "Sorry, nothing was found. Try changing the query or check the input language.")
            return
        }
        service.fetchData(url: url) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    showAlert(message: error.localizedDescription)
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
    
    private func showAlert(message: String) {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        vc.present(alert, animated: true)
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
