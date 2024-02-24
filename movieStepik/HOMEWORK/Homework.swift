//
//  Homework.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 24.02.2024.
//

import Foundation

//let jsonString = """
//{
//		"gender": "male",
//		"name": {
//				"title": "mr",
//				"first", "Natsu",
//				"last": "Dragneel"
//		}
//}
//"""

	// MARK: - Person
	struct Person: Codable {
			let gender: String
			let name: Name
	}

	// MARK: - Name
	struct Name: Codable {
			let title, first, last: String
	}


//let jsonString = """
//{
//		"shapes": [
//				{
//						"type": "circle",
//						"data": {
//								"radius": 5.6
//						}
//				},
//				{
//						"type": "rectangle",
//						"data": {
//								"height": 5.6,
//								"width": 7
//						}
//				}
//		]
//}
//"""

// MARK: - Figure
struct Figure: Codable {
		let shapes: [Shape]
}

// MARK: - Shape
struct Shape: Codable {
		let type: String
		let data: Edges
}

// MARK: - DataClass
struct Edges: Codable {
		let radius, height: Double?
		let width: Int?
}
