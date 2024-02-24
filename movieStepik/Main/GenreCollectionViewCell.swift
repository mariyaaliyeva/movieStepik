//
//  GenreCollectionViewCell.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 20.01.2024.
//

import UIKit

final class GenreCollectionViewCell: UICollectionViewCell {
	
	static let reuseId = "GenreCollectionViewCell"
	
	// MARK: - UI
	private lazy var genreCollectionLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		return label
	}()
	
	// MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		contentView.layer.borderWidth = 2
		contentView.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
		contentView.layer.cornerRadius = 5
		contentView.layer.masksToBounds = true
	}
	
	//MARK: - Public
	func configure(model: Genre) {
		genreCollectionLabel.text = model.name
	}
	
	// MARK: - Setup Views
	private func setupViews() {
		clipsToBounds = true
		contentView.addSubview(genreCollectionLabel)
	}
	
	// MARK: - Setup Constraints
	private func setupConstraints() {
		
		genreCollectionLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(4)
			make.leading.trailing.equalToSuperview().inset(16)
		}
	}
}
