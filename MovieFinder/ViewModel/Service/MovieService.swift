//
//  MovieService.swift
//  MovieFinder
//
//  Created by Riboku🗿 on 28/07/2024.
//

import Foundation

class MovieService {
    private let apiKey = "068105a8a4dc8e48d128c2f84eb0d13e" 
    private let baseURL = "https://api.themoviedb.org/3"

    
    func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(baseURL)/search/movie?query=\(query)&api_key=\(apiKey)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(movieResponse?.results ?? [])
                }
            }
        }.resume()
    }
    
    func fetchTrendingMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(baseURL)/trending/movie/week?api_key=\(apiKey)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(movieResponse?.results ?? [])
                }
            }
        }.resume()
    }
    
    func fetchTopRatedMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(baseURL)/movie/top_rated?api_key=\(apiKey)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(movieResponse?.results ?? [])
                }
            }
        }.resume()
    }
}
