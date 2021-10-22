//
//  HomeViewController.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/9/21.
//

import UIKit

class HomeViewController: UIViewController {
	
	enum Section: Int, CaseIterable {
		case continuous
	}
	
	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
		
	// MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupSubviews()
		configureDataSource()
	}
	
	// MARK: - View Lifecycle Helpers
	
	private func setupSubviews() {
		setupCollectionView()
		setupNavigationBar()
	}
	
	private func setupCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.delegate = self
		
		view.addSubview(collectionView)
	}
	
	private func createLayout() -> UICollectionViewLayout {
		let configuration = UICollectionViewCompositionalLayoutConfiguration()
		configuration.interSectionSpacing = 50
		
		let layout = UICollectionViewCompositionalLayout(
			sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
				guard Section(rawValue: sectionIndex) != nil else { fatalError("unknown section") }
		
				let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
				let item = NSCollectionLayoutItem(layoutSize: itemSize)
				
				let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(220), heightDimension: .absolute(315))
				let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
				
				let section = NSCollectionLayoutSection(group: group)
				section.orthogonalScrollingBehavior = .continuous
				
				let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
				let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
																																 elementKind: "header-element-kind",
																																 alignment: .top)
				
				section.boundarySupplementaryItems = [header]
				return section
		}, configuration: configuration)
		
		return layout
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "TMDB"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	private func configureDataSource() {
		let cellRegistration = UICollectionView.CellRegistration<DiscoverCollectionViewCell, Int> { (cell, indexPath, identifier) in
			cell.contentView.backgroundColor = .red
			cell.layer.borderWidth = 1.0
			cell.layer.borderColor = UIColor.white.cgColor
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
			let section = Section(rawValue: indexPath.section)!
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
