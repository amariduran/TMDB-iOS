//
//  HomeViewController.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/9/21.
//

import UIKit

class HomeViewController: UIViewController {
	
	// MARK: - Properties
	
	lazy var sections: [Section] = [
		TitleSection(title: "DISCOVER NEW PLACES", isShowAllHidden: true),
		TitleSection(title: "POPULAR THIS WEEK", isShowAllHidden: false),
		TitleSection(title: "RECENT GALLERY", isShowAllHidden: true)
	]

	lazy var collectionView: UICollectionView = {
		let compositionalLayout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
			self.sections[sectionIndex].layoutSection()
		}
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
		collectionView.dataSource = self
		collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	// MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupSubviews()
		
//		TMDBMovie.api.send(.popularMovies { result in
//			switch result {
//			case .failure:
//				break
//
//			case .success(let movies):
//				print(movies)
//			}
//		})
	}
	
	// MARK: - View Lifecycle Helpers
	
	private func setupSubviews() {
		setupCollectionView()
		setupNavigationBar()
	}
	
	private func setupCollectionView() {
		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "TMDB"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return sections.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		sections[section].numberOfItems
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
	}
	
}
