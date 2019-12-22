//
//  PopularPeopleViewModel.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
class PopularPeopleViewModel {
	let api: Api
	var popularPeoplePage = 0
	var popularPeoples: Observable<[People]> = .init([])
	var loading: Observable<Bool> = .init(false)
	init(api: Api = DefaultApi()) {
		self.api = api
	}
	
	func getPopularPeoples(page: Int = 1)->Observable<Result<[People], RestError>?> {
		popularPeoplePage = page
		loading.set(true)
		return api.popularPeoples(page: page)
	}
	
	func searchPopularPeoples(page: Int = 1, query: String)->Observable<Result<[People], RestError>?> {
		popularPeoplePage = page
		loading.set(true)
		return api.searchPeoples(page: page, query: query)
	}
}
