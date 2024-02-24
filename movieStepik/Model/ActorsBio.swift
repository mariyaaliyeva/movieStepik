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
	
	enum CodingKeys: String, CodingKey {
		case biography, birthday, deathday, id
		case imdbID = "imdb_id"
		case knownForDepartment = "known_for_department"
		case name
		case placeOfBirth = "place_of_birth"
		case profilePath = "profile_path"
	}
}
