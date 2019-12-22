//
//  ServiceConfig.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
public enum ServerUrl: String{
	case live = "https://api.themoviedb.org/3/"
	case imageStatic = "https://image.tmdb.org/t/p/w500"
}

extension RequestBuilder {
	static var apiBaseUrlString: String {ServerUrl.live.rawValue}
	static var imageServer: String {ServerUrl.imageStatic.rawValue}
    
    convenience init(path: String) {
        let url = URL(string: "\(RequestBuilder.apiBaseUrlString)\(path)")!
        self.init(url: url)
    }
}
