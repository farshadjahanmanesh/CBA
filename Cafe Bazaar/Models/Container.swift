//
//  Models.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Container<T>: Decodable where T: Decodable {
    let page, totalResults, totalPages: Int
    let results: T

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
