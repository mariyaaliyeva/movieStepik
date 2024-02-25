//
//  HomeViewController.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 09.02.2024.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
	
	// MARK: - Props
	private var networkManager = NetworkManager.shared
	private var alamofireNetworkManager = AlamofireNetworkManager.shared
	
	private var themes = Themes.allCases
	
	private lazy var genres: [Genre] = []
	
	private var todayAtTheCinema: [MovieResult] = []
	private var soonAtTheCinema: [MovieResult] = []
	private var trendingMovies: [MovieResult] = []
	
	private var model: [CellModel] =  [] {
		didSet {
			allmMovieTableView.reloadData()
		}
	}
	
	// MARK: - UI
	private lazy var allmMovieTableView: UITableView = {
		var tableView = UITableView(frame: .zero, style: .grouped)
		tableView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "CustomHeader")
		tableView.registerCell(CollectionTableViewCell.self)
		return tableView
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpModels()
		loadGenres()
		setupNavigationBar()
		setupViews()
		setupConstraints()
	}
	
	// MARK: - Navigation bar
	private func setupNavigationBar() {
		self.navigationItem.title = "Movies"
		
		navigationController?.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.white,
		]
	}
	
	// MARK: - SetupViews
	private func setupViews() {
		view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		view.addSubview(allmMovieTableView)
	}
	
	// MARK: - SetupConstraints
	private func setupConstraints() {
		
		allmMovieTableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	// MARK: - Private
	private func setUpModels() {
		
		let queue = DispatchQueue(label: "Queue")
		let semaphore = DispatchSemaphore(value: 1)
		
		queue.async {
			semaphore.wait()
			self.networkManager.loadTodayMovies { [weak self] movies in
				self?.todayAtTheCinema = movies
				self?.model.append(.collectionView(models: movies, rows: 1))
			}
			semaphore.signal()
		}
		
		queue.async {
			semaphore.wait()
			self.networkManager.loadSoonMovies { [weak self] movies in
				self?.soonAtTheCinema = movies
				self?.model.append(.collectionView(models: movies, rows: 1))
			}
			semaphore.signal()
		}
		
		queue.async {
			semaphore.wait()
			self.networkManager.loadTrendingMovies { [weak self] movies in
				self?.trendingMovies = movies
				self?.model.append(.collectionView(models: movies, rows: 1))
			}
			semaphore.signal()
		}
	}
	
	// MARK: - Private
	private func loadGenres() {
		alamofireNetworkManager.fetchGenres { [weak self] genres in
			genres.forEach { genre in
				self?.genres.append(genre)
			}
		}
	}
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
																														"CustomHeader") as! CustomHeader
		
		header.didTapFavorite = { [weak self] in
			if section == 0 {
				let allMovies = ViewController()
				allMovies.movies = self?.todayAtTheCinema ?? []
				self?.navigationController?.pushViewController(allMovies, animated: true)
			}
			if section == 1 {
				let allMovies = ViewController()
				allMovies.movies = self?.soonAtTheCinema ?? []
				self?.navigationController?.pushViewController(allMovies, animated: true)
			}
			if section == 2 {
				let allMovies = ViewController()
				allMovies.movies = self?.trendingMovies ?? []
				self?.navigationController?.pushViewController(allMovies, animated: true)
			}
		}
		if section == 0 {
			header.configure(categoryName: themes[section].rawValue)
			
			
		} else if section == 1 {
			header.configure(categoryName: themes[section].rawValue)
		} else {
			header.configure(categoryName: themes[section].rawValue)
		}
		return header
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		print(model.count)
		return model.count
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch model[section] {
		case .collectionView(_, _): return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch model[indexPath.section] {
			
		case .collectionView(let model, _):
			let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.reuseId, for: indexPath) as! CollectionTableViewCell
			cell.configure(with: model)
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch model[indexPath.section] {
		case .collectionView(_, let rows): return 280 * CGFloat(rows)
		}
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 50
	}
}

