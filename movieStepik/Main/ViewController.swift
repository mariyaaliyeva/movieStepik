//
//  ViewController.swift
//  movieStepik
//
//  Created Mariya Aliyeva on 20.01.2024.
//

import UIKit

final class ViewController: UIViewController {
	
	// MARK: - Props
	var movies: [MovieModel] = [
			MovieModel(name: "Sonic", rating: "7.8", date: "2022-03-30", image: UIImage(named: "sonic")),
			MovieModel(name: "Batman", rating: "9.8", date: "2022-03-30", image: UIImage(named: "batman")),
			MovieModel(name: "Avatar", rating: "8.8", date: "2022-03-30", image: UIImage(named: "avatar")),
			MovieModel(name: "Sonic", rating: "7.8", date: "2022-03-30", image: UIImage(named: "sonic")),
			MovieModel(name: "Batman", rating: "9.8", date: "2022-03-30", image: UIImage(named: "batman")),
			MovieModel(name: "Avatar", rating: "8.8", date: "2022-03-30", image: UIImage(named: "avatar"))
	]
	
	var genres: [GenreCollectionModel] = [
			GenreCollectionModel(nameOfGenre: "All"),
			GenreCollectionModel(nameOfGenre: "Comic"),
			GenreCollectionModel(nameOfGenre: "Action"),
			GenreCollectionModel(nameOfGenre: "Anime"),
			GenreCollectionModel(nameOfGenre: "Horor"),
			GenreCollectionModel(nameOfGenre: "Adventure")
	]
	
	// MARK: - UI
	private lazy var genresCollectionView: UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = .clear
		collectionView.dataSource = self
	//	collectionView.delegate = self
		collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.reuseId)
		return collectionView
	}()
	
	private lazy var movieTableView: UITableView = {
		var tableView = UITableView(frame: .zero, style: .grouped)
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.registerCell(MovieTableViewCell.self)
		return tableView
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigationBar()
		setupViews()
		setupConstraints()
	}
	
	// MARK: - Navigation bar
	private func setupNavigationBar() {
		self.navigationItem.title = "News"

		navigationController?.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.white,
		]
	}
	
	// MARK: - SetupViews
	func setupViews() {
		view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		[genresCollectionView, movieTableView].forEach {
			view.addSubview($0)
		}
	}
	
	// MARK: - SetupConstraints
	func setupConstraints() {
		
		genresCollectionView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
			make.leading.trailing.equalToSuperview().offset(4)
			make.height.equalTo(35)
		}
		
		movieTableView.snp.makeConstraints { make in
			make.top.equalTo(genresCollectionView.snp.bottom).offset(12)
			make.leading.trailing.bottom.equalToSuperview()
		}
	}
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		movies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieTableViewCell
		cell.configure(movies[indexPath.row])
		return cell
	}
}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let actorsViewController = ActorsViewController()
		actorsViewController.actorImage = movies[indexPath.row].image
		navigationController?.pushViewController(actorsViewController, animated: true)
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		genres.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as? GenreCollectionViewCell else {return UICollectionViewCell()}
		cell.configure(model: genres[indexPath.row])
		return cell
	}

}
