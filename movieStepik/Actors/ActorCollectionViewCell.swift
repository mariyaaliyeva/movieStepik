//
//  ActorCollectionViewCell.swift
//  movieStepik
//
//  Created by Rustam Aliyev on 20.01.2024.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
	
	static let reuseId = "ActorCollectionViewCell"
	
	// MARK: - UI

	private lazy var photoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.backgroundColor = #colorLiteral(red: 0.8797428012, green: 0.8797428012, blue: 0.8797428012, alpha: 1)
		return imageView
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
		photoImageView.layer.cornerRadius = 40
	}
	
	//MARK: - Public
	func configure(model: Actors) {
		let url = URL(string: model.posterURL ?? "")!
		photoImageView.kf.setImage(with: url)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		photoImageView.image = nil
	}
	
	// MARK: - Setup Views
	private func setupViews() {
		backgroundColor = .clear
		contentView.addSubview(photoImageView)
	}
	
	// MARK: - Setup Constraints
	private func setupConstraints() {
		
		photoImageView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().offset(2)
			make.leading.trailing.equalToSuperview()
			make.size.equalTo(80)
		}
	}
}
