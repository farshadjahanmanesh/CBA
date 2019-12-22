//
//  Apis.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
protocol Api {
	func popularPeoples(page: Int) -> Observable<Result<[People], RestError>?>
}

final class DefaultApi: Api {
	func popularPeoples(page: Int) -> Observable<Result<[People], RestError>?> {
		return RestService.init(request: GetPopularPeoplesRequest(pageNumber: page)).asObservable
	}
}
