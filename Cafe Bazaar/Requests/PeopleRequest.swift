//
//  PopularRequest.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

struct GetPopularPeoplesRequest: Request {
	let acceptCache: Bool = false
	typealias ResultType = [People]
	
	let pageNumber: Int
	func asURLRequest() throws -> URLRequest {
		try RequestBuilder
			.init(path: "person/popular?page=\(pageNumber)")
			.asURLRequest()
	}
}

//extension GetPopularPeoplesRequest: Mockable {
//	var mock: String { """
//	 {
//	 "page": 2,
//	 "total_results": 10000,
//	 "total_pages": 500,
//	 "results": [{
//			   "popularity": 19.984,
//			   "known_for_department": "Acting",
//			   "name": "Marina Squerciati",
//			   "id": 1100549,
//			   "profile_path": "/j8OI9j2HUnKCIWgu8DBn7Mm3ryl.jpg",
//			   "adult": false,
//			   "known_for": [
//				   {
//					   "poster_path": "/oZjluB568NJVtRrny4rpeApGuNi.jpg",
//					   "vote_count": 1839,
//					   "video": false,
//					   "media_type": "movie",
//					   "id": 109451,
//					   "adult": false,
//					   "backdrop_path": "/qlAeyqhKUfX1f4FWVoFZcHEDCAL.jpg",
//					   "original_language": "en",
//					   "original_title": "Cloudy with a Chance of Meatballs 2",
//					   "genre_ids": [
//						   16,
//						   35,
//						   10751
//					   ],
//					   "title": "Cloudy with a Chance of Meatballs 2",
//					   "vote_average": 6.4,
//					   "overview": "After the disastrous food storm in the first film, Flint and his friends are forced to leave the town. Flint accepts the invitation from his idol Chester V to join The Live Corp Company, which has been tasked to clean the island, and where the best inventors in the world create technologies for the betterment of mankind. When Flint discovers that his machine still operates and now creates mutant food beasts like living pickles, hungry tacodiles, shrimpanzees and apple pie-thons, he and his friends must return to save the world.",
//					   "release_date": "2013-09-26"
//				   },
//				   {
//					   "poster_path": "/xxe77USOk2tPnq7G4cL42gf1OxQ.jpg",
//					   "vote_count": 1786,
//					   "video": false,
//					   "media_type": "movie",
//					   "id": 169917,
//					   "adult": false,
//					   "backdrop_path": "/e56QsaJy1weAUukiK2ZmIGVUALF.jpg",
//					   "original_language": "en",
//					   "original_title": "A Walk Among the Tombstones",
//					   "genre_ids": [
//						   80,
//						   18,
//						   9648,
//						   53
//					   ],
//					   "title": "A Walk Among the Tombstones",
//					   "vote_average": 6.3,
//					   "overview": "Private investigator Matthew Scudder is hired by a drug kingpin to find out who kidnapped and murdered his wife.",
//					   "release_date": "2014-09-18"
//				   },
//				   {
//					   "poster_path": "/foHRwmVZG7m0XMDq15wRuNoKca6.jpg",
//					   "vote_count": 763,
//					   "video": false,
//					   "media_type": "movie",
//					   "id": 22897,
//					   "adult": false,
//					   "backdrop_path": "/lt7K8envOZJGRDfZ8GcN4epSzPd.jpg",
//					   "original_language": "en",
//					   "original_title": "It's Complicated",
//					   "genre_ids": [
//						   35,
//						   10749
//					   ],
//					   "title": "It's Complicated",
//					   "vote_average": 6.4,
//					   "overview": "Ten years after their divorce, Jane and Jake Adler unite for their son's college graduation and unexpectedly end up sleeping together. But Jake is married, and Jane is embarking on a new romance with her architect. Now, she has to sort out her life—just when she thought she had it all figured out.",
//					   "release_date": "2009-12-23"
//				   }
//			   ],
//			   "gender": 1
//		   },
//		   {
//			   "popularity": 24.207,
//			   "known_for_department": "Acting",
//			   "gender": 1,
//			   "id": 9827,
//			   "profile_path": "/4oQWCLK7gd6RNKF0WJipJo7TyFP.jpg",
//			   "adult": false,
//			   "known_for": [
//				   {
//					   "release_date": "2016-05-18",
//					   "id": 246655,
//					   "vote_count": 8856,
//					   "video": false,
//					   "media_type": "movie",
//					   "vote_average": 6.5,
//					   "title": "X-Men: Apocalypse",
//					   "genre_ids": [
//						   28,
//						   12,
//						   14,
//						   878
//					   ],
//					   "original_title": "X-Men: Apocalypse",
//					   "original_language": "en",
//					   "adult": false,
//					   "backdrop_path": "/oQWWth5AOtbWG9o8SCAviGcADed.jpg",
//					   "overview": "After the re-emergence of the world's first mutant, world-destroyer Apocalypse, the X-Men must unite to defeat his extinction level plan.",
//					   "poster_path": "/zSouWWrySXshPCT4t3UKCQGayyo.jpg"
//				   },
//				   {
//					   "release_date": "2011-06-01",
//					   "id": 49538,
//					   "vote_count": 8772,
//					   "video": false,
//					   "media_type": "movie",
//					   "vote_average": 7.3,
//					   "title": "X-Men: First Class",
//					   "genre_ids": [
//						   28,
//						   12,
//						   878
//					   ],
//					   "original_title": "X-Men: First Class",
//					   "original_language": "en",
//					   "adult": false,
//					   "backdrop_path": "/39nstYsfjR6ggyKTtB4Joga2fs8.jpg",
//					   "overview": "Before Charles Xavier and Erik Lensherr took the names Professor X and Magneto, they were two young men discovering their powers for the first time. Before they were arch-enemies, they were closest of friends, working together with other mutants (some familiar, some new), to stop the greatest threat the world has ever known.",
//					   "poster_path": "/7SSm7BfzFoVzmd6fCDccj7qRxc8.jpg"
//				   },
//				   {
//					   "release_date": "2002-05-15",
//					   "id": 1894,
//					   "vote_count": 7835,
//					   "video": false,
//					   "media_type": "movie",
//					   "vote_average": 6.5,
//					   "title": "Star Wars: Episode II - Attack of the Clones",
//					   "genre_ids": [
//						   28,
//						   12,
//						   878
//					   ],
//					   "original_title": "Star Wars: Episode II - Attack of the Clones",
//					   "original_language": "en",
//					   "adult": false,
//					   "backdrop_path": "/vovhXw10DSsRS9yoVbZqb60pXyX.jpg",
//					   "overview": "Following an assassination attempt on Senator Padmé Amidala, Jedi Knights Anakin Skywalker and Obi-Wan Kenobi investigate a mysterious plot that could change the galaxy forever.",
//					   "poster_path": "/2vcNFtrZXNwIcBgH5e2xXCmVR8t.jpg"
//				   }
//			   ],
//			   "name": "Rose Byrne"
//		   }]
//		   }
//	"""}
//}
//
