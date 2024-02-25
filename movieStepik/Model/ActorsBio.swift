//
//  ActorsBio.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 24.02.2024.
//

import Foundation

// MARK: - ActorsBio
struct ActorsBio: Codable {
	let biography, birthday: String
	let deathday: String?
	let id: Int
	let imdbID, knownForDepartment, name, placeOfBirth: String
	let profilePath: String
	let posterURL: String?
	
	enum CodingKeys: String, CodingKey {
		case biography, birthday, deathday, id
		case imdbID = "imdb_id"
		case knownForDepartment = "known_for_department"
		case name
		case placeOfBirth = "place_of_birth"
		case profilePath = "profile_path"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.biography = try container.decode(String.self, forKey: .biography)
		self.birthday = try container.decode(String.self, forKey: .birthday)
		self.deathday = try container.decodeIfPresent(String.self, forKey: .deathday)
		self.id = try container.decode(Int.self, forKey: .id)
		self.imdbID = try container.decode(String.self, forKey: .imdbID)
		self.knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
		self.name = try container.decode(String.self, forKey: .name)
		self.placeOfBirth = try container.decode(String.self, forKey: .placeOfBirth)
		self.profilePath = try container.decode(String.self, forKey: .profilePath)
		
		if let profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath) {
			posterURL = "https://image.tmdb.org/t/p/w200\(profilePath)"
		} else {
			posterURL = nil
		}
	}
}
