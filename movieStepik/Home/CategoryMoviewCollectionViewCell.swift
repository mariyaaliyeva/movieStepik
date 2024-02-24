//
//  MoviewActorsCollectionViewCell.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 10.02.2024.
//

import UIKit
import Kingfisher

class CategoryMoviewCollectionViewCell: UICollectionViewCell {
	
	static let reuseId = "CategoryMoviewCollectionViewCell"
	
	// MARK: - UI
	private lazy var movieImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
		return imageView
	}()
	
	private lazy var ratingStack: UIStackView = {
		let stack = UIStackView()
		stack.distribution = .fillProportionally
		stack.axis = .horizontal
		stack.alignment = .center
		stack.clipsToBounds = true
		return stack
	}()
	
	private lazy var starImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(systemName: "star.fill")
		imageView.tintColor = .white
		return imageView
	}()
	
	private lazy var ratingLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
		return label
	}()
	
	private lazy var movieNameLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.font = .boldSystemFont(ofSize: 14)
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.sizeToFit()
		return label
	}()
	
	private lazy var genreLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .gray
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		return label
	}()
	
	// MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		setupViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		ratingStack.layer.cornerRadius = 5
	}
	
	//MARK: - Public
	func configure(with model: MovieResult, genres: [Genre]) {
		movieNameLabel.text = model.title
		let urlString = "https://image.tmdb.org/t/p/w200" + (
			model.posterPath)
		let url = URL(string: urlString)!
		movieImageView.kf.setImage(with: url)
		ratingLabel.text = (String(format: "%.1f", floor((model.voteAverage) * 10) / 10))
		genreLabel.text = getGenres(by: model.genreIDS, genres: genres)
		
		if model.voteAverage < 4 {
			ratingStack.backgroundColor = .systemRed
		} else if model.voteAverage < 7 {
			ratingStack.backgroundColor = .systemOrange
		} else {
			ratingStack.backgroundColor = .systemGreen
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		genreLabel.text = nil
	}
	
	func getGenres(by ids: [Int], genres: [Genre]) -> String? {
		var array: [String] = []
		for id in ids {
			array.append(genres.first { $0.id == id }?.name ?? "")
		}
		return array.joined(separator: ", ")
	}
	
	// MARK: - Setup Views
	private func setupViews() {
		backgroundColor = .clear
		contentView.addSubview(movieImageView)
		contentView.addSubview(movieNameLabel)
		contentView.addSubview(genreLabel)
		movieImageView.addSubview(ratingStack)
		
		[starImageView, ratingLabel].forEach {
			ratingStack.addArrangedSubview($0)
		}
	}
	
	// MARK: - Setup Constraints
	private func setupConstraints() {
		
		movieImageView.snp.makeConstraints { make in
			make.top.leading.trailing.equalToSuperview()
			make.height.equalTo(210)
		}
		
		starImageView.snp.makeConstraints { make in
			make.height.equalTo(12)
			make.width.equalTo(12)
		}
		
		ratingStack.snp.makeConstraints { make in
			make.top.leading.equalToSuperview().offset(8)
			make.height.equalTo(20)
			make.width.equalTo(36)
		}
		
		movieNameLabel.snp.makeConstraints { make in
			make.top.equalTo(movieImageView.snp.bottom).offset(4)
			make.leading.trailing.equalToSuperview()
		}
		
		genreLabel.snp.makeConstraints { make in
			make.top.equalTo(movieNameLabel.snp.bottom).offset(4)
			make.leading.trailing.equalToSuperview()
		}
	}
}
