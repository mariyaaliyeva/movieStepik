//
//  ViewController.swift
//  movieStepik
//
//  Created Mariya Aliyeva on 20.01.2024.
//

import UIKit
import SkeletonView

final class ViewController: UIViewController {
	
	let zeroView = ZeroView.loadFromNib()
	
	// MARK: - Props
	var movies: [MovieModel] = [
		MovieModel(name: "Sonic", rating: "7.8", date: "2022-03-30", image: UIImage(named: "sonic"), overview: "Отвязный ярко-синий ежик Соник вместе с новообретенным — человеческим — лучшим другом Томом Вачовски он знакомится со сложностями жизни на Земле и противостоит злодейскому доктору Роботнику, который хочет пленить Соника и использовать его безграничные суперсилы для завоевания мирового господства."),
		MovieModel(name: "Batman", rating: "9.8", date: "2022-03-30", image: UIImage(named: "batman"), overview: "После двух лет поисков правосудия на улицах Готэма для своих сограждан Бэтмен становится олицетворением беспощадного возмездия. Когда в городе происходит серия жестоких нападений на представителей элиты, загадочные улики приводят Брюса Уэйна в самые темные закоулки преступного мира, где он встречает Женщину-Кошку, Пингвина, Кармайна Фальконе и Загадочника. Теперь под прицелом оказывается сам Бэтмен, которому предстоит отличить друга от врага и восстановить справедливость во имя Готэма."),
		MovieModel(name: "Avatar", rating: "8.8", date: "2022-03-30", image: UIImage(named: "avatar"), overview: "Джейк Салли — бывший морской пехотинец, прикованный к инвалидному креслу. Несмотря на немощное тело, Джейк в душе по-прежнему остается воином. Он получает задание совершить путешествие в несколько световых лет к базе землян на планете Пандора, где корпорации добывают редкий минерал, имеющий огромное значение для выхода Земли из энергетического кризиса."),
		MovieModel(name: "Sonic", rating: "7.8", date: "2022-03-30", image: UIImage(named: "sonic"), overview: "Отвязный ярко-синий ежик Соник вместе с новообретенным — человеческим — лучшим другом Томом Вачовски он знакомится со сложностями жизни на Земле и противостоит злодейскому доктору Роботнику, который хочет пленить Соника и использовать его безграничные суперсилы для завоевания мирового господства."),
		MovieModel(name: "Batman", rating: "9.8", date: "2022-03-30", image: UIImage(named: "batman"), overview: "После двух лет поисков правосудия на улицах Готэма для своих сограждан Бэтмен становится олицетворением беспощадного возмездия. Когда в городе происходит серия жестоких нападений на представителей элиты, загадочные улики приводят Брюса Уэйна в самые темные закоулки преступного мира, где он встречает Женщину-Кошку, Пингвина, Кармайна Фальконе и Загадочника. Теперь под прицелом оказывается сам Бэтмен, которому предстоит отличить друга от врага и восстановить справедливость во имя Готэма."),
		MovieModel(name: "Avatar", rating: "8.8", date: "2022-03-30", image: UIImage(named: "avatar"), overview: "Джейк Салли — бывший морской пехотинец, прикованный к инвалидному креслу. Несмотря на немощное тело, Джейк в душе по-прежнему остается воином. Он получает задание совершить путешествие в несколько световых лет к базе землян на планете Пандора, где корпорации добывают редкий минерал, имеющий огромное значение для выхода Земли из энергетического кризиса.")
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
		tableView.isSkeletonable = true
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
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "chevron.backward"),
			style: .done,
			target: self,
			action: #selector(barButtonTapped))
		navigationController?.navigationBar.tintColor = .white
	}
	
	@objc func barButtonTapped() {
		self.navigationController?.popViewController(animated: true)
	}

	// MARK: - SetupViews
	private func setupViews() {
		view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		[genresCollectionView, movieTableView].forEach {
			view.addSubview($0)
		}
		
	}
	
	// MARK: - SetupConstraints
	private func setupConstraints() {
		
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
extension ViewController: SkeletonTableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		movies.count
	}
	
	func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
		movies.count
	}
	
	func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
		return MovieTableViewCell.reuseId
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieTableViewCell
		cell.configure(movies[indexPath.row])
		return cell
	}

}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let movieDetais = DetailMovieViewController()
		movieDetais.movieImage = movies[indexPath.row].image
		movieDetais.movieTitle = movies[indexPath.row].name
		movieDetais.dateTitle = movies[indexPath.row].date
		movieDetais.overview = movies[indexPath.row].overview
		movieDetais.raiting = movies[indexPath.row].rating
		navigationController?.pushViewController(movieDetais, animated: true)
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

