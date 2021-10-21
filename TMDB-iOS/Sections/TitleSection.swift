//
//  TitleSection.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/21/21.
//

import UIKit

protocol Section {
	var numberOfItems: Int { get }
	func layoutSection() -> NSCollectionLayoutSection
	func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

struct TitleSection: Section {
	let numberOfItems = 1
	
	private let title: String
	private let isShowAllHidden: Bool
	
	init(title: String, isShowAllHidden: Bool) {
		self.title = title
		self.isShowAllHidden = isShowAllHidden
	}
	
	func layoutSection() -> NSCollectionLayoutSection {
		// Create item size first.
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

		// Create an item and give it the item size we just created.
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		// We create the size of our group. Here we are setting it to the full width, and making the height 73.
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(73))

		// We pass our group size and item to the group.
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		// We take the group and pass it to the section.
		let section = NSCollectionLayoutSection(group: group)
		
		return section
	}
	
	func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as! TitleCollectionViewCell

		cell.set(title: title)
		cell.isShowAllHidden(value: isShowAllHidden)
		return cell
	}
}
