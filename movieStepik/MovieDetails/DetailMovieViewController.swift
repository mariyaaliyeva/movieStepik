//
//  DetailMovieViewController.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 12.02.2024.
//

import UIKit

final class DetailMovieViewController: UIViewController {
	
	// MARK: - Props
	var actorImage: UIImage?
	var movieImage: UIImage?
	var movieTitle: String?
	var dateTitle: String?
	var overview: String?
	var raiting: String?
	
	var actors: [Actor] = [
		Actor(image: UIImage(named: "actor1"), name: "Jennifer Lopez", birthday: "July 24, 1969, Bronx, New York, U.S.", depatment: "Singer, actress", biography: "Jennifer Lopez (born July 24, 1969, Bronx, New York, U.S.) American actress and musician who began appearing in films in the late 1980s and quickly became one of the highest-paid Latina actresses in the history of Hollywood. She later found crossover success in the music industry with a series of pop albums. Lopez, who was born into a family of Puerto Rican descent, took dance lessons throughout her childhood and from an early age had aspirations of fame. She performed internationally in stage musicals, and at age 16 she made her film debut with a small role in My Little Girl (1986). Her television break came in 1990 when she was cast as one of the “Fly Girls,” dancers who appeared on the comedy show In Living Color. After she left the show, she turned her focus to acting, first in several short-lived television series and then in movie roles."),
		Actor(image: UIImage(named: "ben"), name: "Ben Affleck", birthday: "August 15, 1972, Berkeley, California, U.S.", depatment: "Actor, filmmaker", biography: "Ben Affleck (born August 15, 1972, Berkeley, California, U.S.) American actor and filmmaker who played leading roles in action, drama, and comedy films but who was perhaps more renowned for his work as a screenwriter, director, and producer. Affleck grew up in Cambridge, Massachusetts, where he formed a lasting friendship with his neighbour Matt Damon. Affleck’s first role was in a Burger King commercial, and in 1984 he appeared in the Public Broadcasting Service’s miniseries The Voyage of the Mimi. He continued acting as a teenager in the TV movie Hands of a Stranger (1987) and in The Second Voyage of the Mimi (1988). Affleck briefly attended both the University of Vermont and Occidental College but left before graduating, to focus on acting. During his early career his height and stature often got him cast as a bully, and he played minor characters in independent films such as the cult hits Dazed and Confused (1993) and Kevin Smith’s Mallrats (1995). Smith was impressed by Affleck and cast him as the lead in his next film, Chasing Amy (1997). Ben Affleck (born August 15, 1972, Berkeley, California, U.S.) American actor and filmmaker who played leading roles in action, drama, and comedy films but who was perhaps more renowned for his work as a screenwriter, director, and producer. Affleck grew up in Cambridge, Massachusetts, where he formed a lasting friendship with his neighbour Matt Damon. Affleck’s first role was in a Burger King commercial, and in 1984 he appeared in the Public Broadcasting Service’s miniseries The Voyage of the Mimi. He continued acting as a teenager in the TV movie Hands of a Stranger (1987) and in The Second Voyage of the Mimi (1988). Affleck briefly attended both the University of Vermont and Occidental College but left before graduating, to focus on acting. During his early career his height and stature often got him cast as a bully, and he played minor characters in independent films such as the cult hits Dazed and Confused (1993) and Kevin Smith’s Mallrats (1995). Smith was impressed by Affleck and cast him as the lead in his next film, Chasing Amy (1997)."),
		Actor(image: UIImage(named: "angelina"), name: "Angelina Jolie", birthday: "June 4, 1975, Los Angeles, California, U.S.", depatment: "Actress, director", biography: "Angelina Jolie (born June 4, 1975, Los Angeles, California, U.S.) American actress and director known for her sex appeal and edginess as well as for her humanitarian work. She won an Academy Award for her supporting role as a mental patient in Girl, Interrupted (1999). Jolie, daughter of actor Jon Voight, spent much of her childhood in New York before relocating to Los Angeles at age 11. She attended the Lee Strasberg Theatre and Film Institute for two years and then enrolled at Beverly Hills High School. She later studied drama at New York University. In addition to acting in theatre productions, she modeled and appeared in music videos.")
		
	]

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
		label.font = .boldSystemFont(ofSize: 16)
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
		movieImageView.image = movieImage
		movieTitleLabel.text = movieTitle
		dateLabel.text = dateTitle
		descriptionTextView.text = overview
		raitingLabel.text = raiting
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
		actorVC.actorImage = actors[indexPath.row].image
		actorVC.name = actors[indexPath.row].name
		actorVC.birthday = actors[indexPath.row].birthday
		actorVC.job = actors[indexPath.row].depatment
		actorVC.bio = actors[indexPath.row].biography
		self.navigationController?.pushViewController(actorVC, animated: true)
	}
}

