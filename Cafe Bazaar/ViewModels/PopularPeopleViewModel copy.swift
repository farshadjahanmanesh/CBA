//
//  PopularPeopleViewModel.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
class PopularPeopleViewModel: ViewModel {
	let api: Api
	var popularPeoplePage = 0
	var popularPeoples: Observable<[PopularPeople]> = .init([])
	var loading: Observable<Bool> = .init(false)
	let coordinator: PeopleCordinator
	private(set) var store: DataStore
	init(store: DataStore, api: Api = DefaultApi(), coordinator: PeopleCordinator) {
		self.api = api
		self.store = store
		self.coordinator = coordinator
	}
	
	func getPopularPeoples(page: Int = 1)->Observable<Result<Container<[PopularPeople]>, RestError>?> {
		popularPeoplePage = page
		loading.set(true)
		return api.popularPeoples(page: page)
	}
	
	func searchPopularPeoples(page: Int = 1, query: String)->Observable<Result<Container<[PopularPeople]>, RestError>?> {
		popularPeoplePage = page
		loading.set(true)
		return api.searchPeoples(page: page, query: query)
	}
}
