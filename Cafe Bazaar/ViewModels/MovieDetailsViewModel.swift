//
//  MovieDetailsViewModel.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
struct MovieDetailsViewModel: ViewModel {
	let knownFor: KnownFor
	private(set) var store: DataStore
	let coordinator: PeopleCordinator
	init(store: DataStore,knownFor: KnownFor, coordinator: PeopleCordinator) {
		self.knownFor = knownFor
		self.store = store
		self.coordinator = coordinator
	}
	
	func updateWatchList(with knownFor: KnownFor, remove: Bool = false) {
		guard var watchList : [KnownFor] = self.store[.watchList] else {
			if !remove {self.store[.watchList]  = [knownFor]}
			return
		}
		defer {self.store[.watchList] = watchList}
		if remove {
			watchList.removeAll(where: {$0.id == knownFor.id})
		}
		else {
			watchList.append(knownFor)
		}
	}
}
