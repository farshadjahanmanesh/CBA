//
//  Result.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

// MARK: - PopularPeople
struct PopularPeople: Codable {
    let popularity: Double
    let name: String
    let id: Int
    let profilePath: String?
	var profileFullPath: String {
		guard let picture = self.profilePath else{return ""}
		return RequestBuilder.imageServer + picture
	}
    let adult: Bool
    let knownFor: [KnownFor]
    let gender: Int

    enum CodingKeys: String, CodingKey {
        case popularity
        case name, id
        case profilePath = "profile_path"
        case adult
        case knownFor = "known_for"
        case gender
    }
}

