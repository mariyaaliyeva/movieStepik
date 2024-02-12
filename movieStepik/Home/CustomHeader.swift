//
//  CustomHeader.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 11.02.2024.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
	
	var didTapFavorite: (() -> Void)?
	
	// MARK: - UI
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		return label
	}()
	
	private lazy var allButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("All", for: .normal)
		button.tintColor = .orange
		button.addTarget(self, action: #selector(allButtonAction), for: .touchUpInside)
		return button
	}()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		setupViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(categoryName: String) {
		titleLabel.text = categoryName
	}
	
	@objc func allButtonAction() {
		didTapFavorite?()
	}
	
	private func setupViews() {
		backgroundColor = .white
		addSubview(titleLabel)
		addSubview(allButton)
	}
	
	private func setupConstraints() {
		
		titleLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(4)
		}
		
		allButton.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().offset(-8)
		}
	}
}
