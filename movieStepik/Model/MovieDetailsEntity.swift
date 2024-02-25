//
//  MovieDetailsEntity.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 21.02.2024.
//

import Foundation

struct MovieDetailsEntity: Decodable {
	
	enum CodingKeys: String, CodingKey {
		case genres
		case originalTitle = "original_title"
		case releaseDate = "release_date"
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
		case posterPath = "poster_path"
		case overview = "overview"
	}
	
	let originalTitle: String?
	let releaseDate: String?
	let voteAverage: Double?
	let voteCount: Int?
	let posterURL: String?
	let overview: String?
	let genres: [Genre]
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.genres = try container.decode([Genre].self, forKey: .genres)
		self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
		self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
		self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
		self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
		
		if let posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) {
			posterURL = "https://image.tmdb.org/t/p/w200\(posterPath)"
		} else {
			posterURL = nil
		}
		
		self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
	}
}
