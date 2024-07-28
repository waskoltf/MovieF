//
//  Movie.swift
//  MovieFinder
//
//  Created by Riboku🗿 on 28/07/2024.
//

struct Movie: Identifiable, Codable {
    var id: Int
    var title: String
    var overview: String
    var release_date: String
    var poster_path: String?
    var vote_average: Double
}

struct MovieResponse: Codable {
    var results: [Movie]
}
