//
//  DetailMovieViewController.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 12.02.2024.
//

import UIKit

final class DetailMovieViewController: UIViewController {
	
	// MARK: - Props
	
	private var networkManager = NetworkManager.shared
	private var alamofireNetworkManager = AlamofireNetworkManager.shared
	
	var movieID = Int()
  var movieTitle = String()
	
	private lazy var actors: [Actors] = [] {
		didSet {
			self.photoCollectionView.reloadData()
		}
	}
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
	
	private lazy var movieImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleToFill
		imageView.clipsToBounds = true
		return imageView
	}()
	
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
	
	private lazy var raitingLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 12)
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()
	
	private lazy var movieTitleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .boldSystemFont(ofSize: 36)
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()

	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 15)
		label.textAlignment = .left
		label.textColor = .white
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
	
	private lazy var castTitleLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 30)
		label.textAlignment = .center
		label.textColor = .white
		label.text = "Cast"
		return label
	}()

	private lazy var photoCollectionView: UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		collectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.reuseId)
		return collectionView
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setupNavigationBar()
		setupViews()
		setupConstraints()
		loadData()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		raitingView.layer.cornerRadius = 12
	}
	
	// MARK: - Navigation bar
	private func setupNavigationBar() {
		self.navigationItem.title = movieTitle
		
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
		
		alamofireNetworkManager.fetchMovieDetails(id: movieID) { [weak self] movieDetails in
			let url = URL(string: movieDetails.posterURL ?? "")!
			self?.movieImageView.kf.setImage(with: url)
			self?.movieTitleLabel.text = movieDetails.originalTitle
			self?.dateLabel.text = movieDetails.releaseDate
			self?.descriptionTextView.text = movieDetails.overview
			self?.raitingLabel.text = (String(format: "%.1f", floor((movieDetails.voteAverage ?? 0) * 10) / 10))
		}
		
		alamofireNetworkManager.fetchCast(id: movieID) { [weak self] images in
			self?.actors = images
		}
		
	}
	
	// MARK: - Setup Views
	private func setupViews() {
		view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		[movieImageView, movieTitleLabel, dateLabel, overviewView, castTitleLabel, photoCollectionView].forEach {
			contentView.addArrangedSubview($0)
		}
		
		movieImageView.addSubview(raitingView)
		
		[starImageView, raitingLabel].forEach {
			raitingView.addSubview($0)
		}
		
		[descriptionTextView].forEach {
			overviewView.addSubview($0)
		}
	}
	
	// MARK: - Setup Constraints
	private func setupConstraints() {
		
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.leading.trailing.bottom.equalToSuperview()
		}
		
		contentView.snp.makeConstraints { make in
			make.top.equalTo(scrollView).offset(12)
			make.bottom.equalTo(scrollView)
			make.width.equalTo(view.frame.width)
		}
		
		movieImageView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(30)
			make.trailing.equalToSuperview().offset(-30)
			make.height.equalTo(424)
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
			make.leading.equalTo(contentView.snp.leading).offset(32)
			make.trailing.equalTo(contentView.snp.trailing).offset(-32)
		}
		
		dateLabel.snp.makeConstraints { make in
			make.leading.equalTo(contentView.snp.leading).offset(8)
			make.trailing.equalTo(contentView.snp.trailing).offset(-32)
		}
		
		overviewView.snp.makeConstraints { make in
			make.leading.equalTo(contentView.snp.leading)
			make.trailing.equalTo(contentView.snp.trailing)
			make.height.greaterThanOrEqualTo(100)
		}

		descriptionTextView.snp.makeConstraints { make in
			make.top.equalTo(overviewView.snp.top)
			make.leading.equalTo(overviewView.snp.leading)
			make.trailing.equalTo(overviewView.snp.trailing)
			make.bottom.equalTo(overviewView.snp.bottom)
		}
		
		castTitleLabel.snp.makeConstraints { make in
			make.leading.equalTo(contentView.snp.leading).offset(32)
			make.trailing.equalTo(contentView.snp.trailing).offset(-32)
		}
		
		photoCollectionView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.height.equalTo(100)
		}
	}
	
}

// MARK: - UICollectionViewDataSource
extension DetailMovieViewController: UICollectionViewDataSource {
	
	public func collectionView(_ collectionView: UICollectionView,
														 numberOfItemsInSection section: Int) -> Int {
		return actors.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCollectionViewCell", for: indexPath) as? ActorCollectionViewCell else {return UICollectionViewCell() }
		cell.configure(model: actors[indexPath.row])
			return cell
		}
	}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailMovieViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 150, height: 35)
	}
}

// MARK: - UICollectionViewDelegate
extension DetailMovieViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let actorVC = ActorsViewController()
		actorVC.actorId = actors[indexPath.row].id 
		self.navigationController?.pushViewController(actorVC, animated: true)
	}
}

