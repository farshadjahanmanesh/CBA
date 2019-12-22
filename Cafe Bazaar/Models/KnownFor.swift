//
//  KnownFor.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
// MARK: - KnownFor
struct KnownFor: Codable {
	enum Department: String, Codable {
		case acting = "Acting"
	}
	enum MediaType: String, Codable {
		case movie = "movie"
		case tv = "tv"
	}

	enum OriginCountry: String, Codable {
		case cn = "CN"
		case kr = "KR"
		case us = "US"
	}

	enum OriginalLanguage: String, Codable {
		case en = "en"
		case ko = "ko"
		case nl = "nl"
		case zh = "zh"
	}
    let posterPath: String?
	var posterFullPath: String {
		guard let posterPath = self.posterPath else{return ""}
		return RequestBuilder.imageServer + posterPath
	}
    let voteCount: Int
    let video: Bool?
//    let mediaType: MediaType
    let id: Int
    let adult: Bool?
    let backdropPath: String?
//    let originalLanguage: OriginalLanguage
    let originalTitle: String?
//    let genreIDS: [Int]
    let title: String?
    let voteAverage: Double
    let overview: String
    let releaseDate, originalName, name: String?
    let firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case video
//        case mediaType = "media_type"
        case id, adult
        case backdropPath = "backdrop_path"
//        case originalLanguage = "original_language"
        case originalTitle = "original_title"
//        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
    }
}
