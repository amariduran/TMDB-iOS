//
//  HomeViewController.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/9/21.
//

import UIKit

class HomeViewController: UIViewController {
	
	enum Section: Int, CaseIterable {
		case nowPlaying
	}
	
	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupSubviews()
	}
	
	private func setupSubviews() {
		setupCollectionView()
		setupNavigationBar()
	}
	
	private func setupCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.delegate = self
		
		view.addSubview(collectionView)
		
		setupCollectionViewDiffableDataSource()
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "TMDB"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
}

extension HomeViewController {
	
	private func createCollectionViewLayout() -> UICollectionViewLayout {
		let configuration = UICollectionViewCompositionalLayoutConfiguration()
		configuration.interSectionSpacing = 50
		
		let layout = UICollectionViewCompositionalLayout(
			sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
				guard Section(rawValue: sectionIndex) != nil else { fatalError("unknown section") }
		
				let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
																							heightDimension: .fractionalHeight(1))
				let item = NSCollectionLayoutItem(layoutSize: itemSize)
				item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
				
				let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(125),
																							 heightDimension: .absolute(165))
				let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
				
				let section = NSCollectionLayoutSection(group: group)
				section.orthogonalScrollingBehavior = .continuous
				section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
				
				let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
																								heightDimension: .estimated(44))
				let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
																																 elementKind: "header-element-kind",
																																 alignment: .top)
				
				section.boundarySupplementaryItems = [header]
				return section
		}, configuration: configuration)
		
		return layout
	}
	
	private func setupCollectionViewDiffableDataSource() {
		let cellRegistration = UICollectionView.CellRegistration<DiscoverCollectionViewCell, Int> { (cell, indexPath, identifier) in
			cell.contentView.backgroundColor = .red
			cell.contentView.layer.cornerRadius = 4
		}
		
		dataSource = UICollectionViewDiffableDataSource<Int, Int>(
			collectionView: collectionView,
			cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
				return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
			}
		)
		
		let headerSupplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(
			elementKind: "header-element-kind"
		) { supplementaryView, _, indexPath in
			guard let section = Section(rawValue: indexPath.section) else { return }
			supplementaryView.label.text = String(describing: section)
		}
		
		dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) -> UICollectionReusableView in
			self.collectionView.dequeueConfiguredReusableSupplementary(using: headerSupplementaryRegistration, for: indexPath)
		}
		
		var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
		var identifierOffset = 0
		let itemsPerSection = 18
		Section.allCases.forEach {
			snapshot.appendSections([$0.rawValue])
			let maxIdentifier = identifierOffset + itemsPerSection
			snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
			identifierOffset += itemsPerSection
		}
		dataSource.apply(snapshot, animatingDifferences: false)
	}
	
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
}
