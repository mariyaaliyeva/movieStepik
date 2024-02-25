//
//  Actor.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 20.01.2024.
//

import Foundation
import UIKit

struct Actors: Decodable {
	
	enum CodingKeys: String, CodingKey{
		case id
		case name = "name"
		case character
		case profilePath = "profile_path"
		case castID = "cast_id"
	}
	let id: Int
	let name: String?
	let character: String?
	let castID: Int?
	var posterURL: String?
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decodeIfPresent(String.self, forKey: .name)
		self.character = try container.decodeIfPresent(String.self, forKey: .character)

		if let profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath) {
			posterURL = "https://image.tmdb.org/t/p/w200\(profilePath)"
		} else {
			posterURL = nil
		}
		
		self.castID = try container.decodeIfPresent(Int.self, forKey: .castID)
	}
}

struct CastEntity: Decodable {
	let cast: [Actors]
}
