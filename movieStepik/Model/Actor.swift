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
	let profilePath: String?
	let character: String?
	let castID: Int?
}

struct CastEntity: Decodable {
	let cast: [Actors]
}
