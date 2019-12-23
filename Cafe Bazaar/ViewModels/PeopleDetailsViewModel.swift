//
//  PeopleDetailsViewModel.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/23/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
struct PeopleDetailsViewModel: ViewModel {
	let people: PopularPeople
	private(set) var store: DataStore
	let coordinator: PeopleCordinator
	init(store: DataStore,people: PopularPeople, coordinator: PeopleCordinator) {
		self.people = people
		self.store = store
		self.coordinator = coordinator
	}
}
