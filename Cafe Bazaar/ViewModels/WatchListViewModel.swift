//
//  WatchListViewModel.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
struct WatchListViewModel: ViewModel {
	private(set) var store: DataStore
	let coordinator: PeopleCordinator
	var watchList: [KnownFor]  {
		 store[.watchList] ?? []
	}
	
	init(store: DataStore, coordinator: PeopleCordinator) {
		self.store = store
		self.coordinator = coordinator
	}
	
	mutating func remove(movie: KnownFor) {
		var watchList = self.watchList
			watchList.removeAll(where: {$0.id == movie.id})
		store[.watchList] = watchList
		store.remove(for: .movie(movie.id))
	}
}
