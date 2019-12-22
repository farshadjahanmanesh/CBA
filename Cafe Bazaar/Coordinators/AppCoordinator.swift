//
//  AppCoordinator.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
import UIKit
class AppCoordinator {
	unowned var window: UIWindow
	private let disposeBag = DisposeBag()
	private var api: Api = DefaultApi()
	var dataStore: DataStore = SecureDataStore()
	init(window: UIWindow) {
		self.window = window
		DefaultTokenProvider.init(dataStore: dataStore).token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZWUwYWI5OWY1NjZlODNlZGQxOGRkOWJmMTFlMjQyYSIsInN1YiI6IjVkZjkxYzBkZDFhODkzMDAxOTdlYjNlMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.h35v-xdwyZie3teLUCT8-VLnqoW1VqbmMe7_vxMT2NM"
		start()
	}
	
	private func start(){
		
		let peopleViewController = PopularPeopleViewController.init(nibName: "PopularPeopleViewController", bundle: nil)
		peopleViewController.viewModel = PopularPeopleViewModel(api: api)
		let navigation = UINavigationController(rootViewController: peopleViewController)
		self.window.rootViewController = navigation
		self.window.makeKeyAndVisible()
	}
}
