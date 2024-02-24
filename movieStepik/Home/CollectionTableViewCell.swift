//
//  CollectionTableViewCell.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 10.02.2024.
//

import UIKit

final class CollectionTableViewCell: UITableViewCell {
	
	static var reuseId = String(describing: CollectionTableViewCell.self)
	
	// MARK: - Props
	private var networkManager = NetworkManager.shared
	private var models = [MovieResult]()
	private lazy var genres: [Genre] = []
	
	// MARK: - UI
	lazy var movieCollectionView: UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.itemSize = CGSize(width: 130, height: 260)
		layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		collectionView.dataSource = self
		collectionView.register(CategoryMoviewCollectionViewCell.self, forCellWithReuseIdentifier: CategoryMoviewCollectionViewCell.reuseId)
		return collectionView
	}()
	
	// MARK: - Lifecycle
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		loadGenres()
		setupViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Public
	public func configure(with models: [MovieResult]) {
		self.models = models
		movieCollectionView.reloadData()
	}
	
	// MARK: - Private
	private func loadGenres() {
		networkManager.fetchGenres { [weak self] genres in
			genres.forEach { genre in
				self?.genres.append(genre)
			}
		}
	}
	
	// MARK: - Setup Views
	private func setupViews() {
		contentView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		contentView.addSubview(movieCollectionView)
	}
	
	// MARK: - Setup Constraints
	private func setupConstraints() {
		movieCollectionView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(12)
			make.trailing.equalToSuperview().offset(-12)
			make.height.equalTo(280)
		}
	}
}

// MARK: - UICollectionViewDataSource
extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return models.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let model = models[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryMoviewCollectionViewCell.reuseId, for: indexPath) as! CategoryMoviewCollectionViewCell
		cell.configure(with: model, genres: genres)
		return cell
	}
	
}
