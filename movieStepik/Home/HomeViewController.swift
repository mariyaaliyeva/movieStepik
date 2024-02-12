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
	private var model = [CellModel]()
	private var themes = Themes.allCases
	
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
		model.append(.collectionView(models: [
			CollectionTableCellModel(title: "Avatar", imageName: "avatar", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "Car 2", imageName: "batman", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "avatar", imageName: "avatar", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5")
		],
																 rows: 1))
		
		model.append(.collectionView(models: [
			CollectionTableCellModel(title: "Avatar", imageName: "avatar", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "Car 2", imageName: "batman", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "avatar", imageName: "avatar", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5")
		],
																 rows: 1))
		model.append(.collectionView(models: [
			CollectionTableCellModel(title: "Avatar", imageName: "avatar", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "Car 2", imageName: "batman", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "avatar", imageName: "avatar", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5"),
			CollectionTableCellModel(title: "sonic", imageName: "sonic", genreLabel: "Семейный, фантастика, приключения", rating: "5.5")
		],
																 rows: 1))
	}
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
																														"CustomHeader") as! CustomHeader
		
		header.didTapFavorite = { [weak self] in
			let allMovies = ViewController()
			self?.navigationController?.pushViewController(allMovies, animated: true)
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
