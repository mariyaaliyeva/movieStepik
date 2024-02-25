//
//  Movie.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 20.01.2024.
//

import Foundation
import UIKit

import Foundation

// MARK: - Welcome
struct Movie: Decodable {
		let results: [MovieResult]

		enum CodingKeys: String, CodingKey {
				case results
		}
}

// MARK: - Result
struct MovieResult: Codable {
		let backdropPath: String?
		let genreIDS: [Int]
		let id: Int
		let originalTitle, overview, title: String
		let posterURL: String?
	  let posterPath: String?
		let releaseDate: String
		let voteAverage: Double
		let voteCount: Int
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
		self.genreIDS = try container.decode([Int].self, forKey: .genreIDS)
		self.id = try container.decode(Int.self, forKey: .id)
		self.title = try container.decode(String.self, forKey: .title)
		self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
		self.overview = try container.decode(String.self, forKey: .overview)
		self.posterPath = try container.decode(String.self, forKey: .posterPath)
		
		if let posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) {
			posterURL = "https://image.tmdb.org/t/p/w200\(posterPath)"
		} else {
			posterURL = nil
		}
		
		self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
		self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
		self.voteCount = try container.decode(Int.self, forKey: .voteCount)
	}

		enum CodingKeys: String, CodingKey {
				case backdropPath = "backdrop_path"
				case genreIDS = "genre_ids"
				case id, title
				case originalTitle = "original_title"
				case overview
				case posterPath = "poster_path"
				case releaseDate = "release_date"
				case voteAverage = "vote_average"
				case voteCount = "vote_count"
		}
}
