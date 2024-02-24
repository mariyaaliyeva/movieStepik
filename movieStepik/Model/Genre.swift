//
//  Genre.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 20.01.2024.
//

import Foundation

struct Genre: Decodable {
		var id: Int
		var name: String
}

struct GenresEntity: Decodable {
		let genres: [Genre]
}
