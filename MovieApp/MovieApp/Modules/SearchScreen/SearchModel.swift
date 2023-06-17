//
//  MovieListModel.swift
//  MovieApp
//
//  Created by Марина Рябчун on 04.06.2023.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int?
    var results: [Movie]
}

struct Movie: Decodable {
    var image: String?
    var title: String?
    var description: String?
    var imDbRating: String?
    var imDbRatingVotes: String?
    var genres: String?
    var runtimeStr: String?
    var stars: String?
    var plot: String?
}

extension SearchResponse {
    static func mockModel() -> SearchResponse {
        return SearchResponse(results: [
            Movie(image: "one", title: "1title", description: "1description",
                  imDbRating: "1.0", imDbRatingVotes: "1imDbRatingVotes",
                  genres: "1genres", runtimeStr: "1runtimeStr", stars: "1stars",
                  plot: "1plotplotplotplotplotplotplotplotplotplotplotplotplot")
        ])
    }
}
