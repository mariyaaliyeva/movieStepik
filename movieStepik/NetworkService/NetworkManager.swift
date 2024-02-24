//
//  NetworkService.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 20.02.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
	
	static var shared = NetworkManager()
	
	private let session = URLSession(configuration: .default)
	
	private lazy var urlComponents: URLComponents = {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.themoviedb.org"
		components.queryItems = [
			URLQueryItem(name: "api_key", value: "69a4eedfef9f3b9f53f9921135636463")
		]
		return components
	}()
	
	func fetchGenres(completion: @escaping ([Genre]) -> Void) {
		var components = urlComponents
		components.path = "/3/genre/movie/list"
		
		guard let requestUrl = components.url else {
			return
		}
		
		AF.request(requestUrl).responseData { response in
			guard let data = response.data else {
				print("Error: Did not receive data")
				return
			}
			
			do {
				let genresEntity = try JSONDecoder().decode(GenresEntity.self, from: data)
				DispatchQueue.main.async {
					completion(genresEntity.genres)
				}
			} catch {
				DispatchQueue.main.async {
					completion([])
				}
			}
		}
	}
	
	func loadTodayMovies(completion: @escaping ([MovieResult]) -> Void) {
				 loadMovies(path: "/3/movie/now_playing") { movies in
					 completion(movies)
				 }
		 }
		 
		 func loadSoonMovies(completion: @escaping ([MovieResult]) -> Void) {
				 loadMovies(path: "/3/movie/upcoming") { movies in
						 completion(movies)
				 }
		 }
		 
		 func loadTrendingMovies(completion: @escaping ([MovieResult]) -> Void) {
				 loadMovies(path: "/3/trending/movie/week") { movies in
						 completion(movies)
				 }
		 }
		 
		 private func loadMovies(path: String, completion: @escaping ([MovieResult]) -> Void) {
				 var components = urlComponents
				 components.path = path
				 
				 guard let requestUrl = components.url else {
						 return
				 }
						 let task = session.dataTask(with: requestUrl) { data, response, error in
								 guard error == nil else {
										 print("Error: error calling GET")
										 return
								 }
								 guard let data = data else {
										 print("Error: Did not receive data")
										 return
								 }
								 guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
										 print("Error: HTTP request failed")
										 return
								 }
								 do {
										 let moviesEntity = try JSONDecoder().decode(Movie.self, from: data)
										 DispatchQueue.main.async {
												 completion(moviesEntity.results)
										 }
								 } catch {
										 DispatchQueue.main.async {
												 completion([])
										 }
								 }
						 }
				 task.resume()
		 }
	
	func fetchMovieDetails(id: Int, completion: @escaping (MovieDetailsEntity) -> Void) {
		var components = urlComponents
		components.path = "/3/movie/\(id)"
		
		guard let requestUrl = components.url else {
			return
		}
		
		let task = session.dataTask(with: requestUrl) { data, response, error in
			guard error == nil else {
				print("Error: error calling GET")
				return
			}
			
			guard let data else {
				print("Error: Did not recieve data")
				
				return
			}
			
			guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
				print("Error: HTTP request failed")
				return
			}
			
			do {
				let movieDetails = try JSONDecoder().decode(MovieDetailsEntity.self, from: data)
				DispatchQueue.main.async {
					completion(movieDetails)
				}
			} catch {
				DispatchQueue.main.async {
					print("No json!")
				}
			}
		}
		task.resume()
	}
	
	func fetchCast(id: Int, completion: @escaping ([Actors]) -> Void) {
		var components = urlComponents
		components.path = "/3/movie/\(id)/credits"
		
		guard let requestUrl = components.url else {
			return
		}
		
		var request = URLRequest(url: requestUrl)
		
		request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YzIyYzEwNjdjZWM3OWRlMDgyODg5Mjg5NGUzMWJkYyIsInN1YiI6IjY1YjIzYzE3MGYyZmJkMDEzMDY2YTBiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Mp_XUBq4oK4yBkE0QWgpQE-uhK_5ayYAdfjJPRkVyv0", forHTTPHeaderField: "Authorization")
		
		let task = session.dataTask(with: requestUrl) { data, response, error in
			guard error == nil else {
				print("Error: error calling GET")
				return
			}
			
			guard let data else {
				print("Error: Did not recieve data")
				return
			}
			
			guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
				print("Error: HTTP request failed")
				return
			}
			
			do {
				let castDetails = try JSONDecoder().decode(CastEntity.self, from: data)
				DispatchQueue.main.async {
					completion(castDetails.cast)
				}
			} catch {
				DispatchQueue.main.async {
					print("No json!")
				}
			}
		}
		task.resume()
	}
	
	func fetchBioActors(id: Int, completion: @escaping (ActorsBio) -> Void) {
		var components = urlComponents
		components.path = "/3/person/\(id)"
		
		guard let requestUrl = components.url else {
			return
		}
		
		var request = URLRequest(url: requestUrl)
		
		request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YzIyYzEwNjdjZWM3OWRlMDgyODg5Mjg5NGUzMWJkYyIsInN1YiI6IjY1YjIzYzE3MGYyZmJkMDEzMDY2YTBiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Mp_XUBq4oK4yBkE0QWgpQE-uhK_5ayYAdfjJPRkVyv0", forHTTPHeaderField: "Authorization")
		
		let task = session.dataTask(with: requestUrl) { data, response, error in
			guard error == nil else {
				print("Error: error calling GET")
				return
			}
			
			guard let data else {
				print("Error: Did not recieve data")
				return
			}
			
			guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
				print("Error: HTTP request failed")
				return
			}
			
			do {
				let bioDetails = try JSONDecoder().decode(ActorsBio.self, from: data)
				DispatchQueue.main.async {
					completion(bioDetails)
				}
			} catch {
				DispatchQueue.main.async {
					print("No json!")
				}
			}
		}
		task.resume()
	}
}
