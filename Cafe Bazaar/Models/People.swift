//
//  People.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/22/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

typealias ID = Int

struct People: Codable {
    let birthday, knownForDepartment: String
    let id: ID
    let name: String
    let alsoKnownAs: [String]
    let gender: Int
    let biography: String
    let popularity: Double
    let placeOfBirth, profilePath: String
    let adult: Bool

    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case id, name
        case alsoKnownAs = "also_known_as"
        case gender, biography, popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case adult
    }
}

struct PeoplePhoto: Codable {
    let width, height, voteCount: Int
    let filePath: String
    let aspectRatio: Double

    enum CodingKeys: String, CodingKey {
        case width, height
        case voteCount = "vote_count"
        case filePath = "file_path"
        case aspectRatio = "aspect_ratio"
    }
}
