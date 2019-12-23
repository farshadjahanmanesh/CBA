//
//  MovieDetailsViewController.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/22/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit
extension PersistentManager.Key {
	static let watchList: PersistentManager.Key = PersistentManager.Key.init(rawValue: "favorite_watch_list")
}
class MovieDetailsViewController: UIViewController, ViewModelHolder {
	var viewModel: MovieDetailsViewModel!
	
	@IBOutlet private var addToFavoriteButton: UIButton!
	@IBOutlet private var profileImage: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		styles()
	}
	
	private func styles() {
		self.navigationItem.title = viewModel.knownFor.title
		self.profileImage.fromURL(string: viewModel.knownFor.posterFullPath)
		self.addToFavoriteButton.addTarget(self, action: #selector(self.toggleFavorite), for: .touchUpInside)
		updateFavoriteButton()
	}
	private func updateFavoriteButton() {
		let favorite: ID? = self.viewModel.store[.movie(viewModel.knownFor.id)]
		self.addToFavoriteButton.setTitle( favorite == nil ? "Add to favorite" : "Remove Favorite", for: .normal)
	}
	
	@objc
	private func toggleFavorite() {
		if let _ : ID? = self.viewModel.store[.movie(viewModel.knownFor.id)] {
			self.viewModel.store.remove(for: .movie(viewModel.knownFor.id))
			self.viewModel.updateWatchList(with: viewModel.knownFor, remove: true)
		} else {
			self.viewModel.store[.movie(viewModel.knownFor.id)] =  viewModel.knownFor.id
			self.viewModel.updateWatchList(with: viewModel.knownFor)
		}
		updateFavoriteButton()
	}
}
