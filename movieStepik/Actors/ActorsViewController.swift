//
//  ActorsViewController.swift
//  movieStepik
//
//  Created by Rustam Aliyev on 20.01.2024.
//

import UIKit

final class ActorsViewController: UIViewController {
	
	// MARK: - Props
	var actorImage: UIImage?
	
	var actors: [Actor] = [
		Actor(image: UIImage(named: "actor3")),
		Actor(image: UIImage(named: "actor1")),
		Actor(image: UIImage(named: "actor2")),
		Actor(image: UIImage(named: "actor3")),
		Actor(image: UIImage(named: "actor2")),
		Actor(image: UIImage(named: "actor3")),
		Actor(image: UIImage(named: "actor1")),
		Actor(image: UIImage(named: "actor2")),
		Actor(image: UIImage(named: "actor3")),
		Actor(image: UIImage(named: "actor2"))
	]
	
	// MARK: - UI
	private lazy var movieImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleToFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 15
		return imageView
	}()
	
	private lazy var photoCollectionView: UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = self
		collectionView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		collectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.reuseId)
		return collectionView
	}()

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setupViews()
		setupConstraints()
	}
		
	// MARK: - SetupViews
	func setupViews() {
		view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		[movieImageView, photoCollectionView].forEach {
			view.addSubview($0)
		}
		movieImageView.image = actorImage
		navigationController?.navigationBar.tintColor = .white
	}
	
	// MARK: - SetupConstraints
	func setupConstraints() {
		
		movieImageView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
			make.leading.equalToSuperview().offset(32)
			make.trailing.equalToSuperview().offset(-32)
			make.height.equalTo(400)
		}
		
		photoCollectionView.snp.makeConstraints { make in
			make.top.equalTo(movieImageView.snp.bottom).offset(30)
			make.leading.equalToSuperview().offset(4)
			make.trailing.equalToSuperview().offset(-4)
			make.height.equalTo(120)
		}
	}
}

extension ActorsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		actors.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCollectionViewCell", for: indexPath) as? ActorCollectionViewCell else {return UICollectionViewCell()}
		cell.configure(model: actors[indexPath.row])
		return cell
	}
}
