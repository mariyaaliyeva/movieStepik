//
//  Model.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 10.02.2024.
//

import Foundation

enum CellModel {
		case collectionView(models: [CollectionTableCellModel], rows: Int)
}

struct CollectionTableCellModel {
		let title: String
		let imageName: String
	  let genreLabel: String
		let rating: String
}

enum Themes: String, CaseIterable {
	case today = "Today at the cinema"
	case soon = "Soon at the cinema"
	case trending = "Trending movies"
	
}
