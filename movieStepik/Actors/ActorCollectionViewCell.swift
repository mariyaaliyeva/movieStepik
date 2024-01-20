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
		photoImageView.layer.cornerRadius = 15
	}
	
	//MARK: - Public
	func configure(model: Actor) {
		photoImageView.image = model.image
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
			make.height.equalTo(107)
			make.width.equalTo(63)
		}
	}
}
