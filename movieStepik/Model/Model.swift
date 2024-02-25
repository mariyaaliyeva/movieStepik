//
//  Model.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 10.02.2024.
//

import Foundation

enum CellModel {
	case collectionView(models: [MovieResult], rows: Int)
}

enum Themes: String, CaseIterable {
	case today = "Today at the cinema"
	case soon = "Soon at the cinema"
	case trending = "Trending movies"
	
}
