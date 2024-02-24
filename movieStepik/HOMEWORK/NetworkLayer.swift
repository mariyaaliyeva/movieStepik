//
//  NetworkLayer.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 24.02.2024.
//

import Foundation

enum NetworkResult<T> {
	case success(T)
	case failure(NetworkError)
}

enum NetworkError {
	case networkFail
	case incorectJson
	case unknown
	case failedWith(reason: String)
}
