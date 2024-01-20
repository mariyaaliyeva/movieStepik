//
//  MovieTableViewCell.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 20.01.2024.
//

import UIKit
import SnapKit

final class MovieTableViewCell: UITableViewCell {
	
	static var reuseId = String(describing: MovieTableViewCell.self)
	
	// MARK: - UI
	private lazy var raitingView: UIView = {
		let view = UIView()
		view.backgroundColor = .green
		return view
	}()
	
	private lazy var starImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(systemName: "star.fill")
		imageView.tintColor = .white
		return imageView
	}()
	
	private lazy var movieImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleToFill
		imageView.clipsToBounds = true
		imageView.isUserInteractionEnabled = true
		return imageView
	}()
	
	private lazy var movieTitleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .boldSystemFont(ofSize: 40)
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()
	
	private lazy var movieDateLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .boldSystemFont(ofSize: 20)
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()
	
	private lazy var raitingLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 16)
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()
	
	// MARK: - Lifecycle
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		movieImageView.layer.cornerRadius = 15
		raitingView.layer.cornerRadius = 12
	}
	
	//MARK: - Public
			func configure(_ model: MovieModel) {
				movieImageView.image = model.image
				movieTitleLabel.text = model.name
				movieDateLabel.text = model.date
				raitingLabel.text = model.rating
			}
				
	// MARK: - Setup Views
	private func setupViews() {
		contentView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		selectionStyle = .none
		contentView.addSubview(movieImageView)
		
		[raitingView, movieTitleLabel, movieDateLabel].forEach {
			movieImageView.addSubview($0)
		}
		
		[starImageView, raitingLabel].forEach {
			raitingView.addSubview($0)
		}
	}
	
	// MARK: - Setup Constraints
	private func setupConstraints() {
		
		movieImageView.snp.makeConstraints { make in
			make.top.equalTo(contentView).offset(12)
			make.leading.equalTo(contentView).offset(32)
			make.trailing.equalTo(contentView).offset(-32)
			make.bottom.equalTo(contentView).offset(-12)
			make.height.equalTo(400)
		}
		
		raitingView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(12)
			make.leading.equalToSuperview().offset(16)
			make.width.equalTo(50)
			make.height.equalTo(25)
		}
		
		starImageView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(6)
			make.size.equalTo(15)
		}
		
		raitingLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().offset(-4)
		}
		
		movieTitleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(100)
			make.leading.equalToSuperview().offset(32)
			make.trailing.equalToSuperview().offset(-32)
		}
		
		movieDateLabel.snp.makeConstraints { make in
			make.top.equalTo(movieTitleLabel.snp.bottom).offset(8)
			make.leading.equalToSuperview().offset(32)
			make.trailing.equalToSuperview().offset(-32)
		}
	}
}
