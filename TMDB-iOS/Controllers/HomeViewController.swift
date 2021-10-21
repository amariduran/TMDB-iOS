//
//  HomeViewController.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/9/21.
//

import UIKit

class HomeViewController: UIViewController {

	// MARK: - Properties
	
	private var tableView: UITableView!
	private var dataSource: UITableViewDiffableDataSource<Section, Movie>!
	
	private enum Section: CaseIterable {
		case nowPlaying
	}
	
	// MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupSubviews()
		
		TMDBMovie.api.send(.popularMovies { result in
			switch result {
			case .failure:
				break
				
			case .success(let movies):
				self.updateSnapshot(movies: movies.results)
			}
		})
	}
	
	// MARK: - View Lifecycle Helpers
	
	private func setupSubviews() {		
		setupTableView()
		setupNavigationBar()
	}
	
	private func setupTableView() {
		tableView = UITableView(frame: view.bounds)
		tableView.showsVerticalScrollIndicator = false
		tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
		
		view.addSubview(tableView)
		
		dataSource = UITableViewDiffableDataSource(
			tableView: tableView,
			cellProvider: { tableView, indexPath, movie in
				let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath)
			
				var contentConfiguration = cell.defaultContentConfiguration()
				contentConfiguration.text = movie.title
				
				cell.contentConfiguration = contentConfiguration
				return cell
			}
		)
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "TMDB"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	// MARK: - Helpers
	
	private func updateSnapshot(movies: [Movie]) {
		var snapshot = dataSource.snapshot()
		snapshot.appendSections(Section.allCases)
		snapshot.appendItems(movies, toSection: .nowPlaying)
		
		dataSource.apply(snapshot, animatingDifferences: true)
	}
	
}
