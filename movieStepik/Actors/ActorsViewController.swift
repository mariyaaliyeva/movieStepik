//
//  ActorsViewController.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 20.01.2024.
//

import UIKit

final class ActorsViewController: UIViewController {
	
	// MARK: - Props
	var actorId = Int()
	private var networkManager = NetworkManager.shared
	private var alamofireNetworkManager = AlamofireNetworkManager.shared

	// MARK: - UI
	
	private lazy var scrollView: UIScrollView = {
		let scroll = UIScrollView()
    scroll.backgroundColor = .clear
		scroll.showsHorizontalScrollIndicator = false
		scroll.showsVerticalScrollIndicator = false
		scroll.contentInset = .zero
		return scroll
	}()
	
	private var contentView: UIStackView = {
		let stackView = UIStackView()
		stackView.backgroundColor = .clear
		stackView.axis = .vertical
		stackView.spacing = 20
		stackView.alignment = .center
		return stackView
	}()
	
	private lazy var photoView: UIView = {
		let view = UIView()
		return view
	}()
	
	private lazy var actorImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 16)
		label.textAlignment = .center
		label.textColor = .white
		label.text = "Name"
		return label
	}()
	
	private lazy var nameTitleLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 12)
		label.textAlignment = .center
		label.textColor = .gray
		return label
	}()
	
	private lazy var birthdayLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 16)
		label.textAlignment = .center
		label.textColor = .white
		label.text = "Birthday"
		return label
	}()
	
	private lazy var birthdayTitle: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 12)
		label.textAlignment = .left
		label.numberOfLines = 0
		label.textColor = .gray
		return label
	}()
	
	private lazy var depatmentLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 16)
		label.textAlignment = .center
		label.textColor = .white
		label.text = "Depatment"
		return label
	}()
	
	private lazy var jobTitle: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 12)
		label.textAlignment = .left
		label.textColor = .gray
		return label
	}()
	
	private lazy var biographyLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 20)
		label.textAlignment = .left
		label.textColor = .white
		label.text = "Biography"
		return label
	}()
	
	private lazy var overviewView: UIView = {
		let view = UIView()
		view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		return view
	}()
	
	private lazy var descriptionTextView: UITextView = {
		let textView = UITextView()
		textView.font = .systemFont(ofSize: 14)
		textView.textColor = .gray
		textView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		textView.isScrollEnabled = false
		textView.textAlignment = .left
		textView.textContainerInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
		textView.sizeToFit()
		return textView
	}()
	
	private lazy var lastView: UIView = {
		let view = UIView()
		return view
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setupViews()
		setupConstraints()
		loadData()
	}
	
	// MARK: - Navigation bar
	private func setupNavigationBar() {
	
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
	
	private func loadData() {
		
		alamofireNetworkManager.fetchBioActors(id: actorId) { [weak self] bio in
			let url = URL(string: bio.posterURL ?? "")!
			self?.actorImageView.kf.setImage(with: url)
			self?.nameTitleLabel.text = bio.name
			self?.birthdayTitle.text = bio.birthday
			self?.jobTitle.text = bio.knownForDepartment
			self?.descriptionTextView.text = bio.biography
		}
	}
		
	// MARK: - SetupViews
	func setupViews() {
		view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		[actorImageView, nameLabel, nameTitleLabel, birthdayLabel, birthdayTitle, depatmentLabel, jobTitle].forEach {
			photoView.addSubview($0)
		}

		[photoView, biographyLabel, overviewView, lastView].forEach {
			contentView.addArrangedSubview($0)
		}

		[descriptionTextView].forEach {
			overviewView.addSubview($0)
		}

		navigationController?.navigationBar.tintColor = .white
	}
	
	// MARK: - SetupConstraints
	func setupConstraints() {
		
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.leading.trailing.bottom.equalToSuperview()
		}
		
		contentView.snp.makeConstraints { make in
			make.top.equalTo(scrollView).offset(12)
			make.bottom.equalTo(scrollView)
			make.width.equalTo(view.frame.width)
		}
		
		photoView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.height.equalTo(180)
		}
		
		actorImageView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(12)
			make.height.equalTo(180)
			make.width.equalTo(120)
		}
		
		nameLabel.snp.makeConstraints { make in
			make.leading.equalTo(actorImageView.snp.trailing).offset(16)
		}
		
		nameTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(4)
			make.leading.equalTo(actorImageView.snp.trailing).offset(16)
		}
		
		birthdayLabel.snp.makeConstraints { make in
			make.top.equalTo(nameTitleLabel.snp.bottom).offset(4)
			make.leading.equalTo(actorImageView.snp.trailing).offset(16)
		}
		birthdayTitle.snp.makeConstraints { make in
			make.top.equalTo(birthdayLabel.snp.bottom).offset(4)
			make.leading.equalTo(actorImageView.snp.trailing).offset(16)
			make.trailing.equalToSuperview().offset(-2)
		}
		
		depatmentLabel.snp.makeConstraints { make in
			make.top.equalTo(birthdayTitle.snp.bottom).offset(4)
			make.leading.equalTo(actorImageView.snp.trailing).offset(16)
		}
		
		jobTitle.snp.makeConstraints { make in
			make.top.equalTo(depatmentLabel.snp.bottom).offset(4)
			make.leading.equalTo(actorImageView.snp.trailing).offset(16)
			make.trailing.equalToSuperview().offset(-2)
		}
		
		biographyLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(12)
			make.trailing.equalToSuperview().offset(-2)
		}
		
		overviewView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(12)
			make.trailing.equalToSuperview().offset(-12)
			make.height.greaterThanOrEqualTo(100)
		}
		
		descriptionTextView.snp.makeConstraints { make in
			make.top.leading.trailing.bottom.equalToSuperview()
		}
		
		lastView.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(50)
		}
	}
}

