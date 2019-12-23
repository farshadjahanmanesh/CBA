//
//  AppCoordinator.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
import UIKit
class AppCoordinator: PeopleCordinator {
	private unowned var window: UIWindow
	private(set) var navigation: UINavigationController!
	private let disposeBag = DisposeBag()
	private var api: Api = DefaultApi()
	private var dataStore: DataStore = UserDefaultStore()
	init(window: UIWindow) {
		self.window = window
		DefaultTokenProvider.init(dataStore: dataStore).token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZWUwYWI5OWY1NjZlODNlZGQxOGRkOWJmMTFlMjQyYSIsInN1YiI6IjVkZjkxYzBkZDFhODkzMDAxOTdlYjNlMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.h35v-xdwyZie3teLUCT8-VLnqoW1VqbmMe7_vxMT2NM"
		start()
	}
	
	private func start(){
		let peopleViewController = PopularPeopleViewController.init(nibName: "PopularPeopleViewController", bundle: nil)
		peopleViewController.viewModel = PopularPeopleViewModel(store: dataStore, api: api, coordinator: self)
		navigation = UINavigationController(rootViewController: peopleViewController)
		self.window.rootViewController = navigation
		self.window.makeKeyAndVisible()
	}
	
	func coordinateToWatchList() {
		let vc = WatchListViewController.init(nibName: "WatchListViewController", bundle: nil)
		vc.viewModel = WatchListViewModel(store: dataStore, coordinator: self)

		self.navigation.pushViewController(vc, animated: true)
	}
	
	func coordinateToPeopleDetails(for people: PopularPeople) {
		let vc = PeopleDetailsViewController.init(nibName: "PeopleDetailsViewController", bundle: nil)
		vc.viewModel = PeopleDetailsViewModel(store: dataStore, people: people, coordinator: self)

		self.navigation.pushViewController(vc, animated: true)
	}
	
	func coordinateToMovieDetails(for knownFor: KnownFor){
		let vc = MovieDetailsViewController.init(nibName: "MovieDetailsViewController", bundle: nil)
		vc.viewModel = MovieDetailsViewModel(store: dataStore, knownFor: knownFor, coordinator: self)

		self.navigation.pushViewController(vc, animated: true)
	}
}

protocol PeopleCordinator {
	func coordinateToPeopleDetails(for people: PopularPeople)
	func coordinateToMovieDetails(for knownFor: KnownFor)
	func coordinateToWatchList()
}
