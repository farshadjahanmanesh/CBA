//
//  PeopleDetailsViewController.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/22/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit

class PeopleDetailsViewController: UIViewController, ViewModelHolder {
	var viewModel: PeopleDetailsViewModel!
	
	@IBOutlet var addToFavoriteButton: UIButton!
	@IBOutlet var profileImage: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		styles()
    }
	
	private func styles() {
		self.navigationItem.title = viewModel.people.name
		self.profileImage.fromURL(string: viewModel.people.profileFullPath)
		self.addToFavoriteButton.addTarget(self, action: #selector(self.toggleFavorite), for: .touchUpInside)
		 updateFavoriteButton()
	}
	private func updateFavoriteButton() {
		let favorite: ID? = self.viewModel.store[.people(viewModel.people.id)]
		self.addToFavoriteButton.setTitle( favorite == nil ? "Add to favorite" : "Remove Favorite", for: .normal)
	}
	
	@objc
	private func toggleFavorite() {
		if let _ : ID? = self.viewModel.store[.people(viewModel.people.id)] {
			self.viewModel.store.remove(for: .people(viewModel.people.id))
		} else {
			self.viewModel.store[.people(viewModel.people.id)] =  viewModel.people.id
		}
		updateFavoriteButton()
	}
}
